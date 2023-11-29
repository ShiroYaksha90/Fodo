require 'rails_helper'
require 'helpers/users_helper_spec'
RSpec.describe "UsersListings", type: :request do
  describe "GET /users_listings" do
    it "lists all users" do
      @admin_user = User.create!(name: "Example User", email: "example@exampel.com", password: "password", password_confirmation: "password", admin: true)
      @user2 = User.create!(name: "Example User2", email: "example2@exampel.com", password: "password", password_confirmation: "password")
      sign_in_as(@admin_user, @admin_user.password)
      get users_path
      expect(response).to have_http_status(200)
      expect(response.body).to include(@admin_user.name.capitalize)
      expect(response.body).to include(@user2.name.capitalize)
      expect(response.body).to include(@admin_user.recipes.count.to_s)
      expect(response.body).to include(@user2.recipes.count.to_s)
      expect(response.body).to include('Delete')
      expect do
        delete user_path(@user2)
      end.to (change(User, :count).by(-1))
    end
  end
end
