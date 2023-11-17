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
    @recipe.user = User.first
    if @recipe.save
      flash[:success] = 'Recipe was successfully created.'
      redirect_to recipe_path(@recipe)
    else
      flash[:danger] = 'Prevented this Recipe from being saved'
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params) # this is the only line that changed
      flash[:success] = 'Recipe was successfully updated.'
      redirect_to @recipe
    else
      flash[:danger] = 'Prevented this Recipe from being saved'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    Recipe.find(params[:id]).destroy
    flash[:success] = 'Recipe was successfully deleted.'
    redirect_to recipes_path
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :description)
  end
end
