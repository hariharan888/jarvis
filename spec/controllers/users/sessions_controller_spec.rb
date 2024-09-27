require "rails_helper"

describe Users::SessionsController, type: :controller do
  before do
    request.headers["Accept"] = "application/json"
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe "GET #show" do
    let(:user) { create(:user) }
    let(:token) { Warden::JWTAuth::UserEncoder.new.call(user, :user, nil).first }

    context "with a valid token" do
      before do
        request.headers["Authorization"] = "Bearer #{token}"
        sign_in user
      end

      it "returns the current user data" do
        get :show
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)["status"]["message"]).to eq("success")
        expect(JSON.parse(response.body)["data"]["user"]["email"]).to eq(user.email)
      end
    end

    context "without a valid token" do
      before do
        request.headers["Authorization"] = nil
      end

      it "returns an unauthorized response" do
        get :show
        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)["status"]["message"]).to eq("Couldn't find an active session.")
      end
    end

    context "with a discarded user" do
      let(:discarded_user) { create(:user, discarded_at: Time.current) }
      let(:discarded_token) { Warden::JWTAuth::UserEncoder.new.call(discarded_user, :user, nil).first }

      before do
        request.headers["Authorization"] = "Bearer #{discarded_token}"
      end

      it "returns an unauthorized response" do
        get :show
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "POST #create" do
    let(:user) { create(:user) }
    let(:valid_params) { { user: { email: user.email, password: user.password } } }

    context "with valid credentials" do
      it "returns a success response with a token" do
        post :create, params: valid_params
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)["status"]["message"]).to eq("Logged in successfully.")
        expect(response.headers["Authorization"]).to be_present
      end
    end

    context "with invalid credentials" do
      let(:invalid_params) { { user: { email: user.email, password: "wrongpassword" } } }

      it "returns an unauthorized response" do
        post :create, params: invalid_params
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context "with a discarded user" do
      let(:discarded_user) { create(:user, discarded_at: Time.current) }
      let(:discarded_params) { { user: { email: discarded_user.email, password: discarded_user.password } } }

      it "returns an unauthorized response" do
        post :create, params: discarded_params
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "POST #generate_token" do
    let(:user) { create(:user) }
    let(:token) { Warden::JWTAuth::UserEncoder.new.call(user, :user, nil).first }

    context "with a valid token" do
      before do
        request.headers["Authorization"] = "Bearer #{token}"
        sign_in user
      end

      it "returns a new secondary token" do
        post :generate_token
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)["status"]["message"]).to eq("success")
        expect(JSON.parse(response.body)["data"]["token"]).to be_present
      end
    end

    context "without a valid token" do
      before do
        request.headers["Authorization"] = nil
      end

      it "returns an unauthorized response" do
        post :generate_token
        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)["status"]["message"]).to eq("Couldn't find an active session.")
      end
    end
  end

  describe "DELETE #destroy" do
    let(:user) { create(:user) }
    let(:token) { Warden::JWTAuth::UserEncoder.new.call(user, :user, nil).first }

    before do
      request.headers["Authorization"] = "Bearer #{token}"
    end

    context "with a valid token" do
      it "returns a success response" do
        delete :destroy
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)["status"]["message"]).to eq("Logged out successfully.")
      end
    end

    context "without a token" do
      before do
        request.headers["Authorization"] = nil
      end

      it "returns an unauthorized response" do
        delete :destroy
        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)["status"]["message"]).to eq("Couldn't find an active session.")
      end
    end
  end
end
