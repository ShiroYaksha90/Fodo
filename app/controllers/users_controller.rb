class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

    def index
      @users = User.order(:name).page params[:page]
    end

    def new
      @user = User.new
    end

    def create
      @user = User.new(user_params) # Not the final implementation!
      if @user.save
        flash[:success] = "Welcome to the Foodo App!"
        redirect_to @user
      else
        flash[:danger] = "Prevented this User from being saved"
        render 'new', status: :unprocessable_entity
      end
    end

    def show
    end

    def edit
    end

    def update
      if @user.update(user_params)
        flash[:success] = "Profile updated"
        redirect_to @user
      else
        flash[:danger] = "Prevented this User from being updated"
        render 'edit', status: :unprocessable_entity
      end
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end