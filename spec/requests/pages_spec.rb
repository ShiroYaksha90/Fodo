require 'rails_helper'

RSpec.describe 'Pages ', type: :request do
  describe 'Root' do
    it 'renders a successful response' do
      get root_path
      expect(response).to have_http_status(200)
      expect(response.body).to include("Welcome to Foodo App")
      expect(response.body).to include("Sign up or Log in")
    end
  end
end
