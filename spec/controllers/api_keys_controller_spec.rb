require 'rails_helper'

RSpec.describe ApiKeysController, type: :controller do

  let(:api_key) { create(:api_key) }

  context "when the user is logged in" do
    let(:user) { create(:user) }

    before(:example) do
      session[:user_id] = user.id
    end

    describe "GET #index" do
      let(:get_index) { get :index }

      context "when the user has at least one API key" do
        before(:example) do
          user.api_keys << api_key
        end

        it "returns http success" do
          expect( get_index ).to have_http_status :success
        end

        it "renders the :index template" do
          expect( get_index ).to render_template :index
        end
      end
    end

    describe "GET #new" do
      let(:get_new) { get :new }

      it "assigns a new API key to @api_key" do
        get_new
        expect( assigns(:api_key) ).to be_a_new(ApiKey)
      end

      it "renders the :new template" do
        expect( get_new ).to render_template :new
      end
    end

    describe "POST #create" do
      context "when params are valid" do
        let(:post_create) { post :create, api_key: attributes_for(:api_key).except(:user_id) }

        it "adds a new api key to the current user" do
          expect{ post_create }.to change(user.api_keys, :count).by(1)
        end

        it "redirects to API index path" do
          expect( post_create ).to redirect_to api_keys_path
        end
      end

      context "when params are invalid" do
        let(:post_create) { post :create, api_key: attributes_for(:api_key).except(:user_id, :vcode) }

        it "shows the new template" do
          expect( post_create ).to render_template :new
        end
      end
    end

    describe "DELETE #destroy" do
      let(:delete_destroy) { delete :destroy, id: api_key.id }

      context "when the user has at least one API key" do
        before(:example) do
          user.api_keys << api_key
        end

        it "deletes the specified key" do
          expect{ delete_destroy }.to change(ApiKey, :count).by(-1)
        end

        it "redirects to the API index path" do
          expect( delete_destroy ).to redirect_to api_keys_path
        end
      end
    end
  end

  context "when the user is not logged in" do
    it{ expect( get :index ).to redirect_to login_path }
    it{ expect( get :new ).to redirect_to login_path }
    it{ expect( post :create, api_key: attributes_for(:api_key).except(:user_id) ).to redirect_to login_path }
    it{ expect( delete :destroy, id: api_key.id ).to redirect_to login_path }
  end
end
