helpers do
  def current_user
    @_cached_user ||= User.find_by(id: session[:user_id])
  end

  def current_user_id
    current_user.id
  end

  def logged_in?
    session[:user_id] != nil
  end

  def authenticate!
    redirect '/' unless logged_in?
  end
end
