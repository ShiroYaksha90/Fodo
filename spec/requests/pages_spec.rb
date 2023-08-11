require 'rails_helper'

RSpec.describe "Pages ", type: :request do
  # describe "GET /pages" do
  #   it "works! (now write some real specs)" do
  #     get pages_index_url
  #     expect(response).to have_http_status(200)
  #   end
  # end
  describe "GET /show" do
    it "renders a successful response" do
      get pages_home_url
      expect(response).to have_http_status(200) #3
    end
  end
  describe "Root" do
    it "renders a successful response" do
      get root_url
      expect(response).to be_successful #3
    end
  end
end
