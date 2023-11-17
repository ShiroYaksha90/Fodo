require 'rails_helper'

RSpec.feature 'Recipes', type: :feature do
  scenario 'should display recipes' do
    @user = User.create(name: 'chef', email: 'example@example.com', password: 'password')
    @recipe = @user.recipes.build(name: 'Vegetable saute',
                                  description: 'Greate vegetable sautee, add vegetable nad oil')
    @recipe.save
    @recipe2 = @user.recipes.build(name: 'Chicken saute', description: 'Greate Chicken dish')
    @recipe2.save
    visit '/recipes'
    expect(page).to have_selector('h1', text: 'Showing all recipes')
    expect(page).to have_content(@recipe.name)
    expect(page).to have_content(@recipe.description)
    expect(page).to have_link(@recipe.name, href: recipe_path(@recipe))
    expect(page).to have_selector('img', class: 'gravatar')
    expect(page).to have_link('Edit', href: edit_recipe_path(@recipe))
    expect(page).to have_button('Delete', type: 'submit')
    expect(page).to have_content(@recipe2.name)
    expect(page).to have_content(@recipe2.description)
    expect(page).to have_link(@recipe2.name, href: recipe_path(@recipe2))
    expect(page).to have_selector('img', class: 'gravatar')
  end

  scenario 'should display recipe' do
    @user = User.create(name: 'chef', email: 'example@example.com', password: 'password')
    @recipe = @user.recipes.build(name: 'Vegetable saute',
                                  description: 'Greate vegetable sautee, add vegetable nad oil')
    @recipe.save
    visit "/recipes/#{@recipe.id}"
    expect(page).to have_selector('h1', text: @recipe.name.to_s)
    expect(page).to have_selector('p', text: @recipe.description.to_s)
    expect(page).to have_selector('a', text: 'Back to recipes list')
  end

  scenario 'should display new recipe form' do
    visit '/recipes/new'
    expect(page).to have_selector('h1', text: 'Create recipe')
    expect(page).to have_selector('label', text: 'Title')
    expect(page).to have_selector('label', text: 'Description')
    expect(page).to have_selector('input', id: 'recipe_name')
    expect(page).to have_selector('textarea', id: 'recipe_description')
    expect(page).to have_selector('input', class: 'btn btn-danger btn-lg btn-bg col-3')
    expect(page).to have_selector('a', text: 'Back')
    expect(page).to have_link('Back', href: recipes_path)
  end

  scenario 'should display recipe edit form' do
    @user = User.create(name: 'foo', email: 'bar@exampl.com', password: 'password')
    @recipe = @user.recipes.build(name: 'Vegetable saute',description: 'Greate vegetable sautee, add vegetable nad oil')
    @recipe.save
    visit edit_recipe_path(@recipe)
    expect(page).to have_selector('h1', text: 'Edit recipe')
    expect(page).to have_selector('label', text: 'Title')
    expect(page).to have_selector('label', text: 'Description')
    expect(page).to have_selector('input', id: 'recipe_name')
    expect(page).to have_selector('textarea', id: 'recipe_description')
    expect(page).to have_selector('input', class: 'btn btn-danger btn-lg btn-bg col-3')
    expect(page).to have_selector('a', text: 'Back')
    expect(page).to have_link('Back', href: recipes_path)
  end
end
