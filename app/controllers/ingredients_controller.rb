class IngredientsController < ApplicationController
  before_action :set_ingredient, only: [:show, :edit, :update]


    def new

    end

    def create
      
    end

    def edit
      
    end

    def update
      
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
end