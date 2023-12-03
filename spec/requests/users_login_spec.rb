require 'rails_helper'
require 'helpers/users_helper_spec'
RSpec.describe 'UsersLogins', type: :request do
  describe 'GET /users_logins' do
    it 'rejects invalid login' do
      get login_path
      expect(response).to render_template('new')
      post login_path, params: { session: { email: '', password: '' } }
      expect(response).to render_template('new')
      expect(logged_in?).to be_falsey
      expect(flash[:danger]).to be_present
      get root_path
      expect(flash[:danger]).to_not be_present
    end
    it 'accepts valid login' do
      @user = User.create!(name: 'Example User', email: 'example@example.com', password: 'password',
                           password_confirmation: 'password')
      get login_path
      expect(response).to render_template('new')
      post login_path, params: { session: { email: @user.email, password: @user.password } }
      expect(logged_in?).to be_truthy
      expect(response).to redirect_to(@user)
      follow_redirect!
      expect(response).to render_template('users/show')
      expect(response.body).to include(@user.name)
      expect(response.body).to include(@user.recipes.count.to_s)
      expect(response.body).to include('Log out')
      expect(response.body).to_not include('Log in')
      expect(response.body).to include("#{@user.name.capitalize}'s Profile")
    end
  end
end
