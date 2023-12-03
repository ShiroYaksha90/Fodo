require 'rails_helper'

RSpec.describe 'UsersSignups', type: :request do
  describe 'GET /users_signups' do
    it 'works! (now write some real specs)' do
      get signup_path
      expect(response).to have_http_status(200)
    end

    it 'rejects invalid signup' do
      get signup_path
      expect do
        post users_path, params: { user: { username: '',
                                           email: 'user@invalid',
                                           password: 'foo',
                                           password_confirmation: 'bar' } }
      end.not_to change(User, :count)
      expect(response).to render_template('users/new')
    end

    it 'accepts valid signup' do
      get signup_path
      expect do
        post users_path,
             params: { user: { name: 'Example User', email: 'example@example.com', password: 'password',
                               password_confirmation: 'password' } }
      end.to change(User, :count).by(1)
      expect(response).to redirect_to(user_path(User.last))
      follow_redirect!
      expect(response).to render_template('users/show')
      expect(response.body).to include('Welcome to the Foodo App!')
    end
  end
end
