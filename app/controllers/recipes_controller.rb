class RecipesController < ApplicationController

  

  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new 
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      # do something
      redirect_to @recipe
    else
      # do something else
      render :new
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update 
    @recipe = Recipe.find(params[:id])
    if @recipe.update_attributes(recipe_params)
      redirect_to @recipe
    else
      render :edit
    end
  end

  def destroy 
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to recipes_path
  end

  private
    def recipe_params
      params.require(:recipe).permit(:name, :description)
    end
end
