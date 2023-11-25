require 'rails_helper'

RSpec.describe "UsersLogins", type: :request do
  describe "GET /users_logins" do
    it "rejects invalid login" do
      get login_path
      post login_path, params: { session: { email: "", password: "" } }
      expect(flash[:danger]).to be_present
      get root_path
      expect(flash[:danger]).to_not be_present
    end
    it "accepts valid login" do
      @user = User.create!(name: "Example User", email: "example@example.com", password: "password", password_confirmation: "password")
      get login_path
      post login_path, params: { session: { email: @user.email, password: @user.password } }
      # expect(flash[:success]).to be_present
      get user_path(@user)
      expect(flash[:success]).to_not be_present
    end
  end
end
