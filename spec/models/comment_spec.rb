require 'rails_helper'

RSpec.describe Comment, type: :model do
  before(:each) do
    @user = User.create(name: 'Test User', email: 'test@example.com', password: 'password')
    @recipe = @user.recipes.build(name: 'Test Recipe', description: 'Test Recipe Description')
    @recipe.save
    @comment = @recipe.comments.build(user_id: @user.id, content: 'Test Comment')
    @comment.save
  end
  it 'is valid with valid attributes' do
    expect(@comment).to be_valid
  end
  it 'is not valid without a user_id' do
    @comment.user_id = nil
    expect(@comment).to_not be_valid
  end
  it 'is not valid without a content' do
    @comment.content = nil
    expect(@comment).to_not be_valid
  end
  it 'is not valid with a content longer than 150 characters' do
    @comment.content = 'a' * 151
    expect(@comment).to_not be_valid
  end
  it 'belongs to a user' do
    expect(@comment.user.name).to eq('Test User')
  end
  it 'belongs to a recipe' do
    expect(@comment.recipe.name).to eq('Test Recipe')
  end
end
