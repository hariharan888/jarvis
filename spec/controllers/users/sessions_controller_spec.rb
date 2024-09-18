require "rails_helper"

describe Users::SessionsController, type: :controller do
  describe "POST #create" do
    let(:user) { create(:user) }
    let(:valid_params) { { user: { email: user.email, password: user.password } } }

    before do
      request.headers["Accept"] = "application/json"
      @request.env["devise.mapping"] = Devise.mappings[:user]
    end

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
