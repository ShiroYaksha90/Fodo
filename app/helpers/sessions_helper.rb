module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def current_user
    return unless session[:user_id]

    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    reset_session
    @current_user = nil
  end

  def require_user
    return if logged_in?

    flash[:danger] = 'You must be logged in to perform that action'
    redirect_to login_path
  end
end
