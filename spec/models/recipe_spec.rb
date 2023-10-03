require 'rails_helper'

RSpec.describe Recipe, type: :model do
  before(:each) do
    @recipe = Recipe.new(name: "Burger", description: "This is a burger")
  end

  it "is valid with valid attributes" do
    expect(@recipe).to be_valid
  end

  it "is not valid without a name" do
    @recipe.name = nil
    expect(@recipe).to_not be_valid
  end

  it "is not valid without a description" do
    @recipe.description = nil
    expect(@recipe).to_not be_valid
  end

  it "is not valid with a name longer than 50 characters" do
    @recipe.name = "a" * 51
    expect(@recipe).to_not be_valid
  end

  it "is not valid with a description longer than 500 characters" do  
    @recipe.description = "a" * 501
    expect(@recipe).to_not be_valid
  end
end
