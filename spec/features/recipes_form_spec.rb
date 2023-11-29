require 'rails_helper'
require 'helpers/recipes_helper_spec'
RSpec.feature 'RecipesForms', type: :feature do
  before(:each) do
    @user = User.create(name: 'foo', email: 'foo@example.com', password: 'password', password_confirmation: 'password')
    features_sign_in(@user.email, @user.password)
  end
  scenario 'should display new recipe form' do
    visit new_recipe_path
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
