require 'rails_helper'
require 'helpers/users_helper_spec'
RSpec.describe 'RecipesDeletes', type: :request do
  describe 'GET /recipes_deletes' do
    before(:each) do
      @user = User.create!(name: 'example test', email: 'test@example.com', password: 'password', password_confirmation: 'password')
      sign_in_as(@user, @user.password)
      @recipe = @user.recipes.build(name: 'Vegetable saute',
                                    description: 'Greate vegetable sautee, add vegetable and oil')
      @recipe.save
    end
    it 'successfully delete a recipe' do
      get recipe_path(@recipe)
      expect(response).to render_template(:show)
      expect(response.body).to include(@recipe.name)
      expect(response.body).to include(@recipe.description)
      expect(response.body).to include(@recipe.user.name)
      expect do
        delete recipe_path(@recipe)
      end.to change(Recipe, :count).by(-1)
      expect(response).to redirect_to(recipes_path)
      follow_redirect!
      expect(response).to render_template(:index)
      expect(response.body).to include('Recipe was successfully deleted.')
      expect(response.body).not_to include(@recipe.name)
      expect(response.body).not_to include(@recipe.description)
      expect(response.body).not_to include(@recipe.user.name)
    end
  end
end
