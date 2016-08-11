get '/questions' do
  @questions = Question.all
  erb :'questions/index'
end

get '/questions/new' do
  erb :'questions/new'
end

post '/questions' do
  question = Question.new(params[:question])
  question.asker_id = current_user_id
  if(question.save)
    redirect '/'
  else
    @errors = question.errors.full_messages
    erb :'questions/new'
  end
end

get '/questions/:id'do
  question = Question.find(params[:id])
  question.views += 1
  erb :'/questions/show'
end

# do we need updating privileges?
# get '/questions/:id/edit' do
# end

# put '/questions/:id' do
#   if update
#   else errors
# end

# what about deleting privileges?
# delete '/questions/:id' do
# end