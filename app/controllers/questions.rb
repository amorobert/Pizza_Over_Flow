get '/questions' do
  @questions = Question.all
  erb :'questions/index'
end

get '/questions/new' do
  # authenticate!
  erb :'questions/new'
end

post '/questions' do
  authenticate!
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
  authenticate!
  comment = Comment.new(commenter_id: current_user_id, commentable_id: params[:answer_id], commentable_type: 'Answer', content: params[:content])
  comment.save
  @answer_comment_errors = comment.errors.full_messages

  redirect "/questions/#{params[:question_id]}"
  if request.xhr?
    if comment.save
      status 200
      erb :'comments/_new_comment', layout: false, :locals => {comment: comment}
    else
      status 422
    end
  else
    comment.save
    redirect "/questions/#{params[:question_id]}"
  end
end

post "/questions/:question_id/comment" do
  authenticate!
  comment = Comment.new(commenter_id: current_user_id, commentable_id: params[:question_id].to_i, commentable_type: 'Question', content: params[:content])

  @question_comment_errors = comment.errors.full_messages


  redirect "/questions/#{params[:question_id]}"
  if request.xhr?
    if comment.save
      status 200
      erb :'comments/_new_comment', layout: false, :locals => {comment: comment}
    else
      status 422
    end
  else
    redirect "/questions/#{params[:question_id]}"
  end
end

post '/questions/:question_id/answers' do

  answer = Answer.new(answerer_id: current_user_id, question_id: params[:question_id].to_i, content: params["content"])

  @answer_errors = answer.errors.full_messages

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
