require 'rails_helper'
include OmniAuthTestHelper

RSpec.describe SessionsController, type: :controller do

  describe "GET #new" do
    context "when the user is not logged in" do
      it "returns http success" do
        session[:user_id] = nil
        get :new
        expect(response).to have_http_status(:success)
      end
    end

    context "when the user is logged in" do
      it "redirects to home" do
        session[:user_id] = create(:user).id
        get :new
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "POST #create" do
    context "when the provider is google" do
      before(:example) do
        mock_auth_setup
        get :create, provider: "google_oauth2"
      end

      it "creates a new session" do
        expect(session[:user_id]).to_not eq nil
      end

      it "redirects to home" do
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the user's session" do
      delete :destroy
      expect(session[:user_id].nil?).to eq true
    end

    it "redirects to the login path" do
      delete :destroy
      expect(response).to redirect_to login_path
    end
  end
end
