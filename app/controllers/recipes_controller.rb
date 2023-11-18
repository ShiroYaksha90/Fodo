class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[show edit update]
  def index
    @recipes = Recipe.all
  end

  def show; end

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

  def edit; end

  def update
    if @recipe.update(recipe_params)
      flash[:success] = 'Recipe was successfully updated.'
      redirect_to @recipe
    else
      flash[:danger] = 'Prevented this Recipe from being saved'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    set_recipe.destroy
    flash[:success] = 'Recipe was successfully deleted.'
    redirect_to recipes_path
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:name, :description)
  end
end
