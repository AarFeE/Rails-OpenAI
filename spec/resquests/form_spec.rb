require 'rails_helper'

RSpec.describe "Forms", type: :request do
  describe "GET /forms" do
    it "returns http success" do
      get "/forms"
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /forms" do
    let(:valid_attributes) {
      {
        form: {
          name: "Test Form",
          description: "A test description",
          processed_in_job: false
        }
      }
    }

    it "creates a new form" do
      expect {
        post "/forms", params: valid_attributes
      }.to change(Form, :count).by(1)
    end
  end
end
