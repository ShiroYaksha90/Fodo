class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_user, only: %i[edit update destroy]
  before_action :require_admin, only: [:destroy]
    def index
      @users = User.order(:name).page params[:page]
    end

    def new
      @user = User.new
    end

    def create
      @user = User.new(user_params)
      if @user.save
        log_in @user
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

    def destroy
      if !@user.admin?
      @user.destroy
      flash[:success] = "User deleted"
      redirect_to users_url
      end
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

  def require_user
    return if current_user == @user || current_user.admin?
    flash[:danger] = 'You can only edit or delete your own account'
    redirect_to users_path
  end

  def require_admin
    if logged_in? && !current_user.admin?
      flash[:danger] = 'Only admin users can perform that action'
      redirect_to root_path
    end
  end
end