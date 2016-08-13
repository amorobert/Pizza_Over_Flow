get '/users/new' do #new user registration
  erb :'/users/new'
end

post '/users' do #registration form submission
  user = User.new(params[:user])
  if user.save
    session[:user_id] = user.id
    redirect '/'
  else
    @errors = user.errors.full_messages
    if request.xhr?
        erb :'/users/new', :layout => false
    else
      erb :'/users/new'
    end
  end
end

get '/login' do
  if request.xhr?
    erb :'/users/index', :layout => false
  else
    erb :'/users/index'
  end
end

post '/login' do #user login
    user = User.authenticate(params[:name], params[:password])
    if user
      session[:user_id] = user.id
      redirect '/'
    else
      @errors = ["Could not authenticate user.  Please try again."]
      if request.xhr?
          erb :'/users/index', :layout => false
      else
        erb :'/users/index'
      end
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
  authenticate!
  if current_user.update(params[:user])
    if request.xhr?
      current_user.attributes.to_json
    else
      redirect "/users/#{current_user_id}"
    end
  else
    @errors = current_user.errors.messages
    erb :"users/edit"
  end
end


delete '/users' do #user logout
  session[:user_id] = nil
  redirect '/'
end
