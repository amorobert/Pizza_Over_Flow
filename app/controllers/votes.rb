post '/votes' do
	if params[:question]
		@question = Question.find(params[:question])
		if params[:upvote]
			puts "upvote"
			Vote.create(value: 1, votable_type: "Question", votable_id: @question.id, voter_id: 7)
			redirect "/questions/#{@question.id}"
		elsif params[:downvote]
			puts "downvote"
			Vote.create(value: -1, votable_type: "Question", votable_id: @question.id, voter_id: 7)
			redirect "/questions/#{@question.id}"
		end
	elsif params[:answer]
		@answer = Answer.find(params[:answer])
		if params[:upvote]
			puts "upvote"
			Vote.create(value: 1, votable_type: "Answer", votable_id: @answer.id, voter_id: 7)
			redirect "/questions/#{@answer.question_id}"
		elsif
			puts "downvote"
			Vote.create(value: -1, votable_type: "Answer", votable_id: @answer.id, voter_id: 7)
			redirect "/questions/#{@answer.question_id}"
		end
	end
end