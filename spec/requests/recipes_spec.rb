require 'rails_helper'

RSpec.describe 'Recipes', type: :request do
  describe 'GET /recipes' do
    before(:each) do
      @user = User.create(name: 'chef', email: 'chef@example.com', password: 'password')
      @recipe = @user.recipes.build(name: 'Vegetable saute',
                                    description: 'Greate vegetable sautee, add vegetable nad oil')
      @recipe.save
      @recipe2 = @user.recipes.build(name: 'Chicken saute', description: 'Greate Chicken dish')
      @recipe2.save
    end
    it 'works! (now write some real specs)' do
      get recipes_path
      expect(response).to have_http_status(200)
    end

    it 'displays recipes' do
      get recipes_path
      expect(response).to render_template(:index)
      expect(response.body).to include(@recipe.name)
      expect(response.body).to include(@recipe.description)
      expect(response.body).to include(@recipe2.name)
      expect(response.body).to include(@recipe2.description)
    end

    it 'should get recipes show' do
      get recipe_path(@recipe)
      expect(response).to have_http_status(200)
      expect(response).to render_template(:show)
      expect(response.body).to include(@recipe.name)
      expect(response.body).to include(@recipe.description)
      expect(response.body).to include(@recipe.user.name)
    end

    it 'should get recipes new' do
      get new_recipe_path
      expect(response).to have_http_status(200)
      expect(response).to render_template(:new)
      expect(response.body).to include('Create recipe')
      expect(response.body).to include('Title')
      expect(response.body).to include('Description')
      expect(response.body).to include('Create')
    end

    it 'creates a valid recipe' do
      get new_recipe_path
      expect(response).to render_template(:new)
      expect do
        post recipes_path, params: { recipe: { name: 'Chocolate Chip Cookies', description: 'Best cookies ever!' } }
      end.to change(Recipe, :count).by(1)
      expect(response).to redirect_to(recipe_path(Recipe.last))
      follow_redirect!
      expect(response).to render_template(:show)
      expect(response.body).to include('Recipe was successfully created.')
      expect(response.body).to include(Recipe.last.name.capitalize.to_s)
      expect(response.body).to include(Recipe.last.description.to_s)
    end

    it 'rejects invalid recipe submissions' do
      get new_recipe_path
      expect(response).to render_template(:new)
      expect do
        post recipes_path, params: { recipe: { name: '', description: '' } }
      end.to_not change(Recipe, :count)
      expect(response).to render_template(:new)
      expect(response.body).to include('Prevented this Recipe from being saved')
      expect(response.body).to include('Name can&#39;t be blank')
      expect(response.body).to include('Description can&#39;t be blank')
    end
  end
end
