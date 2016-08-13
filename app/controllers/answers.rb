get '/answers/new/:question_id' do
	# authenticate!
	@current_question = Question.find(params[:question_id])

	erb :'answers/new'
end

post '/questions/:question_id/answers' do
	authenticate!
	answer = Answer.new(answerer_id: current_user_id, question_id: params[:question_id].to_i, content: params["content"])

	@answer_errors = answer.errors.full_messages
	puts "_______ERRRORS________"
	puts @answer_errors
	puts params["content"]

	if request.xhr?
		if answer.save
			status 200
			erb :'answers/_new_answer', layout: false, :locals => {answer: answer}
		else
			status 422
		end
	else
		answer.save
		redirect "/questions/#{params[:question_id]}"
	end

end
