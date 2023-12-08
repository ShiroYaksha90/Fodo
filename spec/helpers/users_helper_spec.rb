require 'rails_helper'

def sign_in_as(user, password)
  post login_path, params: { session: { email: user.email, password: } }
end

def logged_in?
  !session[:user_id].nil?
end

def features_signup
  visit signup_path
  fill_in :user_name, with: 'foo'
  fill_in :user_email, with: 'foo@example.com'
  fill_in :user_password, with: 'password'
  fill_in :user_password_confirmation, with: 'password'
  click_button 'Create account'
end
