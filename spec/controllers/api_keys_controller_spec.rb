require 'rails_helper'

RSpec.describe ApiKeysController, type: :controller do

  context "when the user is logged in" do
    before(:example) do
      sign_in
    end

    describe "GET #index" do
      context "when the user has at least one API key" do
        before(:example) do
          @current_user.api_keys << create(:api_key)
          get :index
        end

        it "returns http success" do
          expect(response).to have_http_status(:success)
        end

        it "renders the :index template" do
          expect(response).to render_template :index
        end
      end
    end

    describe "GET #new" do
      before(:example) do
        get :new
      end

      it "assigns a new API key to @api_key" do
        expect(assigns(:api_key)).to be_a_new(ApiKey)
      end

      it "renders the :new template" do
        expect(response).to render_template :new
      end
    end

    describe "POST #create" do
      context "when valid parameters are supplied" do
        before(:example) do
          post :create, api_key: attributes_for(:api_key).except(:user_id)
        end

        it "creates a new api key on the current user" do
          expect(assigns(:api_key)).not_to be_new_record
        end

        it "redirects to API index path" do
          expect(response).to redirect_to api_keys_path
        end
      end
    end

    describe "DELETE #destroy" do
      context "when the user has at least one API key" do
        before(:example) do
          @api_key = create(:api_key)
          @current_user.api_keys << @api_key
        end
        subject { delete :destroy, id: @api_key.id }

        it "deletes the specified key" do
          expect {
            subject
          }.to change(ApiKey, :count).by(-1)
        end

        it "redirects to the API index path" do
          expect(subject).to redirect_to api_keys_path
        end
      end
    end
  end
end
