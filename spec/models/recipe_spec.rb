require 'rails_helper'

RSpec.describe Recipe, type: :model do
  before(:each) do
    @user = User.create(name: 'Test User', email: 'tester@gmail.com', password: 'password',
                        password_confirmation: 'password')
    @recipe = @user.recipes.build(name: 'Test Recipe', description: 'Test Recipe Description')
    @recipe.save
    @recipe.ingredients.create(name: 'Test Ingredient')
    @comment = @recipe.comments.create(content: 'Test Comment', user_id: @user.id)
  end

  it 'is valid with valid attributes' do
    expect(@recipe).to be_valid
  end

  it 'is not valid without a name' do
    @recipe.name = nil
    expect(@recipe).to_not be_valid
  end

  it 'is not valid without a description' do
    @recipe.description = nil
    expect(@recipe).to_not be_valid
  end

  it 'is not valid with a name longer than 50 characters' do
    @recipe.name = 'a' * 51
    expect(@recipe).to_not be_valid
  end

  it 'is not valid with a description longer than 500 characters' do
    @recipe.description = 'a' * 501
    expect(@recipe).to_not be_valid
  end

  it 'Recipe without user_id should be invalid' do
    @recipe.user_id = nil
    expect(@recipe).to_not be_valid
  end
  it 'checks if the recipe has ingredients' do
    expect(@recipe.ingredients.count).to eq(1)
    expect(@recipe.ingredients.first.name).to eq('Test Ingredient')
  end
  it 'checks if the recipe has recipe_ingredients' do
    expect(@recipe.recipe_ingredients.count).to eq(1)
    expect(@recipe.recipe_ingredients.first.ingredient.name).to eq('Test Ingredient')
  end
  it 'checks if the recipe has comments' do
    expect(@recipe.comments.count).to eq(1)
    expect(@recipe.comments.first.content).to eq('Test Comment')
  end
  it 'checks if the recipe has users through comments' do
    expect(@recipe.user).to eq(@user)
    expect(@recipe.user.name).to eq('Test User')
  end
end
