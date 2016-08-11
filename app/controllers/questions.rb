get '/questions' do
  @questions = Question.all
  erb :'questions/index'
end

get '/questions/new' do
  authenticate!
  erb :'questions/new'
end

post '/questions' do
  user_id = current_user.id
  question = Question.new(params[:question])
  question.asker_id = user_id
  if(question.save)
    redirect '/'
  else
    @errors = question.errors.full_messages
    erb :'questions/new'
  end
end

