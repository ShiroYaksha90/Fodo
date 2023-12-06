class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[show edit update destroy]
  before_action :logged_in_user, only: %i[edit update destroy]
  before_action :require_user, except: %i[index show]
  def index
    @recipes = Recipe.order(:name).page params[:page]
  end

  def show
    @comments = @recipe.comments.order(:content).page params[:page]
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user
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
    params.require(:recipe).permit(:name, :description, ingredient_ids: [])
  end
end
