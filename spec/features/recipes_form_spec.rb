require 'rails_helper'

RSpec.feature 'RecipesForms', type: :feature do
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
    @recipe = @user.recipes.build(name: 'Vegetable saute',
                                  description: 'Greate vegetable sautee, add vegetable nad oil')
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
