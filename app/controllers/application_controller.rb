class ApplicationController < ActionController::Base
  include SessionsHelper
  skip_before_action :verify_authenticity_token

  private

  def logged_in_user
    return if logged_in?

    # store_location
    flash[:danger] = 'Please log in.'
    redirect_to login_url, status: :see_other
  end
end
