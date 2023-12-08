require 'rails_helper'
require 'helpers/recipes_helper_spec'
RSpec.feature 'Recipes', type: :feature do
  scenario 'should display all recipes' do
    @user = User.create(name: 'chef', email: 'example@example.com', password: 'password')
    @recipe = @user.recipes.create(name: 'Vegetable saute',
                                   description: 'Greate vegetable sautee, add vegetable nad oil')
    @recipe2 = @user.recipes.create(name: 'Chicken saute', description: 'Greate Chicken dish')
    visit '/recipes'
    expect(page).to have_selector('h1', text: 'Showing all recipes')
    expect(page).to have_content(@recipe.name)
    expect(page).to have_content(@recipe.description)
    expect(page).to have_link(@recipe.name, href: recipe_path(@recipe))
    expect(page).to have_selector('img', class: 'gravatar')
    expect(page).to have_content(@recipe2.name)
    expect(page).to have_content(@recipe2.description)
    expect(page).to have_link(@recipe2.name, href: recipe_path(@recipe2))
    expect(page).to have_selector('img', class: 'gravatar')
  end

  scenario 'should display recipe' do
    @user = User.create(name: 'chef', email: 'example@example.com', password: 'password')
    features_sign_in(@user.email, @user.password)
    @recipe = @user.recipes.create(name: 'Vegetable saute',
                                   description: 'Greate vegetable sautee, add vegetable nad oil')
    visit "/recipes/#{@recipe.id}"
    expect(page).to have_selector('h1', text: @recipe.name.to_s)
    expect(page).to have_selector('p', text: @recipe.description.to_s)
    expect(page).to have_selector('img', class: 'gravatar')
    expect(page).to have_selector('a', text: 'Edit')
    expect(page).to have_button('Delete')
    expect(page).to have_selector('a', text: 'Back to recipes list')
  end
end
