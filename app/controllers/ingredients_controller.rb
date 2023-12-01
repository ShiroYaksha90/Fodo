class IngredientsController < ApplicationController

    def new

    end

    def create
      
    end

    def edit
      
    end

    def update
      
    end

    def show
      
    end

    def index
        @ingredients = Ingredient.order(:name).page params[:page]
    end
end