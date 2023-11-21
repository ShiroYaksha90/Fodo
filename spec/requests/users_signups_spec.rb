require 'rails_helper'

RSpec.describe "UsersSignups", type: :request do
  describe "GET /users_signups" do
    it "works! (now write some real specs)" do
      get signup_path
      expect(response).to have_http_status(200)
    end

    it "rejects invalid signup" do
      get signup_path
      expect {
        post users_path, params: { user: { username: "",
                                           email: "user@invalid",
                                           password: "foo",
                                           password_confirmation: "bar" } }
      }.not_to change(User, :count)
      expect(response).to render_template('users/new')
    end
  end
end
