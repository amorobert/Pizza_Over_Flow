get '/answers/new/:question_id' do 
	@current_question = Question.find(params[:question_id])

	erb :'answers/new'
end

post '/questions/:question_id/answers' do

	answer = Answer.new(answerer_id: current_user_id, question_id: params[:question_id].to_i, content: params[:content])
	answer.save
	@answer_errors = answer.errors.full_messages
	
	
	redirect "/questions/#{params[:question_id]}"
	
end