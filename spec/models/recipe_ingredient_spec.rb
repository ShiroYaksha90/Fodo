require 'rails_helper'

RSpec.describe RecipeIngredient, type: :model do
  before(:each) do
    @user = User.create(name: 'Test User', email: 'test@example.com', password: 'password')
    @recipe = @user.recipes.build(name: 'Test Recipe', description: 'Test Recipe Description')
    @recipe.save
    @ingredient = @recipe.ingredients.create(name: 'Test Ingredient')
  end
  it 'is valid with valid attributes' do
    @recipe_ingredient = @recipe.recipe_ingredients.build(ingredient_id: @ingredient.id)
    expect(@recipe_ingredient).to be_valid
  end
  it 'is not valid without a recipe_id' do
    @recipe_ingredient = @recipe.recipe_ingredients.build(ingredient_id: nil)
    expect(@recipe_ingredient).to_not be_valid
  end
  it 'is not valid without an ingredient_id' do
    @recipe_ingredient = @recipe.recipe_ingredients.build(ingredient_id: nil)
    expect(@recipe_ingredient).to_not be_valid
  end
  it 'belongs to a recipe' do
    @recipe_ingredient = @recipe.recipe_ingredients.build(ingredient_id: @ingredient.id)
    expect(@recipe_ingredient.recipe.name).to eq('Test Recipe')
  end
  it 'belongs to an ingredient' do
    @recipe_ingredient = @recipe.recipe_ingredients.build(ingredient_id: @ingredient.id)
    expect(@recipe_ingredient.ingredient.name).to eq('Test Ingredient')
  end
end
