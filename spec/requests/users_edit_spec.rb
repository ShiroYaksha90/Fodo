require 'rails_helper'
require 'helpers/users_helper_spec'
RSpec.describe "UsersEdits", type: :request do
  describe "GET /users_edits" do
    it "renders the edit form" do
      @user = User.create!(name: "Test User", email: "test@example.com", password: "password", password_confirmation: "password")
      sign_in_as(@user, @user.password)
      get edit_user_path(@user)
      expect(response).to render_template(:edit)
      expect(response.body).to include("Edit user")
      expect(response.body).to include("Name")
      expect(response.body).to include("Email")
      expect(response.body).to include("Password")
      expect(response.body).to include("Confirm password")
    end
    it "accepts valid submission" do
      @user = User.create!(name: "Test User", email: "test@example.com", password: "password", password_confirmation: "password")
      patch user_path(@user), params: { user: { name: "New Name", email: "new@example.com", password: "newpassword", password_confirmation: "newpassword" } }
      expect(response).to redirect_to(@user)
      follow_redirect!
      expect(response).to render_template(:show)
      expect(response.body).to include("New Name")
    end
    it "rejects invalid submission" do
      @user = User.create!(name: "Test User", email: "test@example.com", password: "password", password_confirmation: "password")
      patch user_path(@user), params: { user: { name: "New Name", email: "", password: "newpassword", password_confirmation: "newpassword" } }
      expect(response).to render_template(:edit)
      expect(response.body).to include("Prevented this User from being updated")
      expect(response.body).to include("Email can&#39;t be blank")
      expect(response.body).to include("Email is invalid")
    end
  end
end
