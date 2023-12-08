require 'rails_helper'
require 'helpers/users_helper_spec'
RSpec.describe 'RecipesEdits', type: :request do
  describe 'GET /recipes_edits' do
    before(:each) do
      @user = User.create!(name: 'example test', email: 'testexample@example.com', password: 'password',
                           password_confirmation: 'password')
      sign_in_as(@user, @user.password)
      @recipe = @user.recipes.build(name: 'Vegetable saute',
                                    description: 'Greate vegetable sautee, add vegetable and oil')
      @recipe.save
    end
    it 'works! (now write some real specs)' do
      get edit_recipe_path(@recipe)

      expect(response).to have_http_status(200)
    end
    it 'displays recipe edit form' do
      get edit_recipe_path(@recipe)
      expect(response).to render_template(:edit)
      expect(response.body).to include('Edit recipe')
      expect(response.body).to include('Title')
      expect(response.body).to include('Description')
      expect(response.body).to include('Edit')
    end

    it 'updates a valid recipe' do
      get edit_recipe_path(@recipe)
      expect(response).to render_template(:edit)
      expect(response.body).to include('Edit recipe')
      patch recipe_path(@recipe), params: { recipe: { name: 'Updated name', description: 'Updated description' } }
      expect(response).to redirect_to(recipe_path(@recipe))
      follow_redirect!
      expect(response).to render_template(:show)
      expect(response.body).to include('Recipe was successfully updated.')
      expect(response.body).to include('Updated name')
      expect(response.body).to include('Updated description')
    end
    it 'rejects invalid recipe update' do
      get edit_recipe_path(@recipe)
      expect(response).to render_template(:edit)
      expect(response.body).to include('Edit recipe')
      patch recipe_path(@recipe), params: { recipe: { name: '', description: '' } }
      expect(response).to render_template(:edit)
      expect(response.body).to include('Prevented this Recipe from being saved')
      expect(response.body).to include('Name can&#39;t be blank')
      expect(response.body).to include('Description can&#39;t be blank')
    end
  end
end
