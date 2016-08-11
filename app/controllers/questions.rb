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
  @question = Question.find(params[:id])
  @answers = @question.answers
  @question.views += 1
  erb :'/questions/show'
end

post "/questions/:question_id/answers/:answer_id/comment" do 

  comment = Comment.new(commenter_id: current_user_id, commentable_id: params[:answer_id], commentable_type: 'Answer', content: params[:content])
  comment.save
  @answer_comment_errors = comment.errors.full_messages
  
  
  redirect "/questions/#{params[:question_id]}"
end

post "/questions/:question_id/comment" do
  comment = Comment.new(commenter_id: current_user_id, commentable_id: params[:question_id], commentable_type: 'Question', content: params[:content])
  comment.save
  @question_comment_errors = comment.errors.full_messages
  
  
  redirect "/questions/#{params[:question_id]}"

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
