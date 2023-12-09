class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      cookies.signed[:user_id] = user.id
      log_in user
      redirect_to user, status: :see_other
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new', status: :unauthorized
    end
  end

  def destroy
    log_out
    redirect_to root_url, status: :see_other
  end
end
