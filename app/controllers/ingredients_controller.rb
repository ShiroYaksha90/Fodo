class IngredientsController < ApplicationController
  before_action :set_ingredient, only: %i[show edit update]

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

  def update; end

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
end
