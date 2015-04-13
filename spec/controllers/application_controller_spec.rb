require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do

  controller do
    def index
    end
  end

  context "when the user is not logged in" do
    it "redirects to the login page" do
      session[:user_id] = nil
      get :index
      expect(response).to redirect_to login_path
    end
  end

  context "when the user is logged in, but has no API keys" do
    it "redirects to the new api key path" do
      session[:user_id] = create(:user).id
      get :index
      expect(response).to redirect_to new_api_key_path
    end
  end

end
