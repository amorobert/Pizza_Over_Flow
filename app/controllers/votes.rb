post '/votes' do
	@question = Question.find(params[:question])
	p @question
	if params[:upvote]
		puts "upvote"
		Vote.create(value: 1, votable_type: "Question", votable_id: @question.id, voter_id: 7)
		redirect "/questions/#{@question.id}"
	elsif params[:downvote]
		puts "downvote"
		Vote.create(value: -1, votable_type: "Question", votable_id: @question.id, voter_id: 7)
		redirect "/questions/#{@question.id}"
	end
end