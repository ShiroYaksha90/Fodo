require 'rails_helper'

RSpec.describe 'Recipes', type: :request do
  describe 'GET /recipes' do
    before(:each) do
      @user = User.create(name: 'chef', email: 'chef@example.com')
      @recipe = @user.recipes.build(name: 'Vegetable saute',
                                    description: 'Greate vegetable sautee, add vegetable nad oil', user: @user)
      @recipe.save
      @recipe2 = @user.recipes.build(name: 'Chicken saute', description: 'Greate Chicken dish', user: @user)
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
      expect(response.body).to include(@recipe.name)
      expect(response.body).to include(@recipe.description)
      expect(response.body).to include(@recipe.user.name)
    end
  end
end
