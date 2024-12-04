require 'rails_helper'

RSpec.describe FormsController, type: :controller do
  describe "GET #index" do
    it "returns a successful response" do
      get :index
      expect(response).to be_successful
    end

    it "assigns @forms" do
      form = Form.create(name: "Test Form", processed_in_job: false)
      get :index
      expect(assigns(:forms)).to eq([ form ])
    end
  end

  describe "GET #show" do
    it "returns a successful response" do
      form = Form.create(name: "Test Form", processed_in_job: false)
      get :show, params: { id: form.id }
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      let(:valid_attributes) {
        {
          name: "New Form",
          description: "Test Description",
          processed_in_job: false
        }
      }

      it "creates a new form" do
        expect {
          post :create, params: { form: valid_attributes }
        }.to change(Form, :count).by(1)
      end

      it "redirects to the new form" do
        post :create, params: { form: valid_attributes }
        expect(response).to redirect_to(Form.last)
      end
    end

    context "with invalid attributes" do
      let(:invalid_attributes) {
        { name: nil }
      }

      it "does not create a new form" do
        expect {
          post :create, params: { form: invalid_attributes }
        }.to_not change(Form, :count)
      end

      it "renders the new template" do
        post :create, params: { form: invalid_attributes }
        expect(response).to render_template(:new)
      end
    end
  end
end
