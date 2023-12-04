class IngredientsController < ApplicationController
  before_action :set_ingredient, only: %i[show edit update]
  before_action :require_admin, except: %i[index show]
  def new
  @ingredient = Ingredient.new
  end

  def create
  @ingredient = Ingredient.new(ingredient_params)
  if @ingredient.save
    flash[:success] = 'Ingredient added successfully'
    redirect_to @ingredient
  else
    flash[:danger] = 'Prevented the ingredient from being saved'
    render 'new', status: :unprocessable_entity
  end
  end

  def edit; end

  def update
    if @ingredient.update(ingredient_params)
      flash[:success] = 'Ingredient updated successfully'
      redirect_to @ingredient
    else
      flash[:danger] = 'Prevented this Ingredient from being updated'
      render 'edit', status: :unprocessable_entity
    end
  end

  def show
    @ingredient_recipes = @ingredient.recipes.order(:name).page params[:page]
  end

  def index
    @ingredients = Ingredient.order(:name).page params[:page]
  end

  private

  def set_ingredient
    @ingredient = Ingredient.find(params[:id])
  end

  def ingredient_params
    params.require(:ingredient).permit(:name)
  end

  def require_admin
    if !logged_in? || (logged_in? and !current_user.admin)
      flash[:danger] = 'Only admin users can preform this action'
      redirect_to ingredients_path
    end
  end
end
