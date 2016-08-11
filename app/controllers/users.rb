
get '/users/new' do #new user registration
  erb :'/users/new'
end

post '/users' do #registration form submission
  user = User.new(params[:user])
  if user.save
    session[:user_id] = user.id
    redirect '/'
  else
    errors = user.errors.full_messages
    erb :'/users/new'
  end
end

get '/login' do #####temporary login route######
  erb :'/users/index'
end

post '/login' do #user login
  user = User.authenticate(params[:name], params[:password])
  if user
    session[:user_id] = user.id
    redirect '/'
  else
    @errors = ["Could not authenticate user.  Please try again."]
    erb :'/users/index'
  end
end

get '/logout' do
  #authorize_access
  session[:user_id] = nil
  redirect '/'
end

get '/users/:id' do
  @user = User.find(params[:id])
  erb :"/users/show"
end

get "/users/:id/edit" do
  erb :"/users/edit"
end

put "/users/:id" do
  if current_user.update(params[:user])
    redirect "/users/#{current_user_id}"
  else
    @errors = current_user.errors.messages
    erb :"users/edit"
  end
end


delete '/users' do #user logout
  session[:user_id] = nil
  redirect '/'
end
