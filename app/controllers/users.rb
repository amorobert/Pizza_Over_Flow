get '/users/new' do #new user registration
  erb :'/users/new'
end

get 'users/:user_id' do

end

post '/users' do #registration form submission
  user = User.new(params[:user])
  if user.save
    session[:user_id] = user.id
    redirect '/'
  else
    @errors = user.errors.full_messages
    erb :'/users/new'
  end
end

put '/users' do #user login
  user = User.authenticate(params[:email], params[:password])
  if user
    session[:user_id] = user.id
    redirect '/'
  else
    @errors = ['invalid credentials']
    erb :'/users/index'
  end
end

delete '/users' do #user logout
  session[:user_id] = nil
  redirect '/'
end
