post '/votes' do
	authenticate!
	if params[:question]
		@question = Question.find(params[:question])
		puts "_________________________________"
		p @question
		if params[:upvote]
			puts "upvote"
			Vote.create(value: 1, votable_type: "Question", votable_id: @question.id, voter_id: session[:user_id])
			redirect "/questions/#{@question.id}"
		elsif params[:downvote]
			puts "downvote"
			Vote.create(value: -1, votable_type: "Question", votable_id: @question.id, voter_id: session[:user_id])
			redirect "/questions/#{@question.id}"
		end
	elsif params[:answer]
		@answer = Answer.find(params[:answer])
		puts "_________________________________"
		p @answer
		if params[:upvote]
			puts "upvote"
			Vote.create(value: 1, votable_type: "Answer", votable_id: @answer.id, voter_id: session[:user_id])
			redirect "/questions/#{@answer.question_id}"
		elsif params[:downvote]
			puts "downvote"
			Vote.create(value: -1, votable_type: "Answer", votable_id: @answer.id, voter_id: session[:user_id])
			redirect "/questions/#{@answer.question_id}"
		end
	end
end

put '/votes/:id' do
	authenticate!
	@vote = Vote.find(params[:id])
	puts "_________________________________"
	puts @vote.value
	@question = Question.find(@vote.votable_id)
	puts @question.title
	if @vote.votable_type == "Question"
		if params[:upvote] && @vote.value == 1
			@vote.update_attributes(value: 0)
			puts "_________________________________"
			puts "+1 to 0"
		elsif params[:upvote] && @vote.value == -1
			@vote.update_attributes(value: 0)
			puts "_________________________________"
			puts "-1 to 1"
		elsif params[:downvote] && @vote.value == -1
			@vote.update_attributes(value: 0)
			puts "-1 to 0"
			puts "_________________________________"
		elsif params[:downvote] && @vote.value == 1
			@vote.update_attributes(value: 0)
			puts "_________________________________"
			puts "1 to -1"
		elsif params[:upvote] && @vote.value == 0
			@vote.update_attributes(value: 1)
		elsif params[:downvote] && @vote.value == 0
			@vote.update_attributes(value: -1)
		end
	elsif @vote.votable_type == "Answer"
		if params[:upvote] && @vote.value == 1
			@vote.update_attributes(value: 0)
			puts "_________________________________"
			puts "+1 to 0"
		elsif params[:upvote] && @vote.value == -1
			@vote.update_attributes(value: 0)
			puts "_________________________________"
			puts "-1 to 1"
		elsif params[:downvote] && @vote.value == -1
			@vote.update_attributes(value: 0)
			puts "-1 to 0"
			puts "_________________________________"
		elsif params[:downvote] && @vote.value == 1
			@vote.update_attributes(value: 0)
			puts "_________________________________"
			puts "1 to -1"
		elsif params[:upvote] && @vote.value == 0
			@vote.update_attributes(value: 1)
		elsif params[:downvote] && @vote.value == 0
			@vote.update_attributes(value: -1)
		end
	end
	redirect "/questions/#{@question.id}"
end
