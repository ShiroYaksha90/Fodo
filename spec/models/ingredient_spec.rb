require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  before(:each) do
    @user = User.create(name: 'Test User', email: 'test@example.com', password: 'password')
    @recipe = @user.recipes.build(name: 'Test Recipe', description: 'Test Recipe Description')
    @recipe.save
    @ingredient = @recipe.ingredients.create(name: 'Test Ingredient')
  end

  it 'is valid with valid attributes' do
    expect(@ingredient).to be_valid
  end

  it 'is not valid without a name' do
    @ingredient.name = nil
    expect(@ingredient).to_not be_valid
  end
  it 'is not valid with a name longer than 25 characters' do
    @ingredient.name = 'a' * 26
    expect(@ingredient).to_not be_valid
  end

  it 'has many recipes' do
    expect(@ingredient.recipes.count).to eq(1)
    expect(@ingredient.recipes.first.name).to eq('Test Recipe')
  end
  it 'has many recipe_ingredients' do
    expect(@ingredient.recipe_ingredients.count).to eq(1)
    expect(@ingredient.recipe_ingredients.first.recipe.name).to eq('Test Recipe')
  end
end
