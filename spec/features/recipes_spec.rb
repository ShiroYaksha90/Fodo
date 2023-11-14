require 'rails_helper'

RSpec.feature "Recipes", type: :feature do
  scenario 'should display recipes' do
    @user = User.create(name: 'chef', email: 'example@example.com', password: 'password')
    @recipe = @user.recipes.build(name: 'Vegetable saute', description: 'Greate vegetable sautee, add vegetable nad oil')
    @recipe.save
    @recipe2 = @user.recipes.build(name: 'Chicken saute', description: 'Greate Chicken dish')
    @recipe2.save
    visit '/recipes'
    expect(page).to have_selector('h1', text: 'Showing all recipes')
    expect(page).to have_content(@recipe.name)
    expect(page).to have_content(@recipe.description)
    expect(page).to have_content(@recipe2.name)
    expect(page).to have_content(@recipe2.description)
  end

  scenario 'should display recipe' do
    @user = User.create(name: 'chef', email: 'example@example.com', password: 'password')
    @recipe = @user.recipes.build(name: 'Vegetable saute', description: 'Greate vegetable sautee, add vegetable nad oil')
    @recipe.save
    visit "/recipes/#{@recipe.id}"
    expect(page).to have_selector('h1', text: "#{@recipe.name}")
    expect(page).to have_selector('p', text: "#{@recipe.description}")
  end

  scenario 'should display new recipe form' do
    visit '/recipes/new'
    expect(page).to have_selector('h1', text: 'Create recipe')
    expect(page).to have_selector('label', text: 'Title')
    expect(page).to have_selector('label', text: 'Description')
    expect(page).to have_selector('input', id: 'recipe_name')
    expect(page).to have_selector('textarea', id: 'recipe_description')
    expect(page).to have_button('Create', type: 'submit')
    expect(page).to have_selector('a', text: 'Back')
  end
end
