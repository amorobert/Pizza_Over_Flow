get '/answers/new/:question_id' do 
	@current_question = Question.find(params[:question_id])

	erb :'answers/new'
end

post '/answers/new/:question_id' do

	answer = Answer.new(answerer_id: current_user_id, question_id: params[:question_id].to_i, content: params[:content])
	answer.save
	@errors = answer.errors.full_messages
	redirect "/answers/new/#{params[:question_id]}"
end