require 'rails_helper'

def sign_in_as(user, password)
    post login_path, params: { session: { email: user.email, password: password } }
end

def logged_in?
    !session[:user_id].nil?
end