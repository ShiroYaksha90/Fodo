require 'rails_helper'

RSpec.describe 'UsersShows', type: :request do
  describe 'GET /users_shows' do
    it 'renders the user with recipes' do
      @user = User.create!(name: 'Test User', email: 'test@example.com', password: 'password',
                           password_confirmation: 'password')
      @recipe = @user.recipes.create!(name: 'Test Recipe', description: 'Test Description')
      @recipe2 = @user.recipes.create!(name: 'Test Recipe 2', description: 'Test Description 2')
      get user_path(@user)
      expect(response).to render_template(:show)
      expect(response.body).to include(@user.name)
      expect(response.body).to include(@recipe.name)
      expect(response.body).to include(@recipe.description)
      expect(response.body).to include(@recipe2.name)
      expect(response.body).to include(@recipe2.description)
    end
  end
end
