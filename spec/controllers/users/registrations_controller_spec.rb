require 'rails_helper'

RSpec.describe Users::RegistrationsController, type: :controller do
  before do
    request.headers["Accept"] = "application/json"
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @request.env["warden-jwt_auth.token"] = 'test-token'
  end

  describe 'POST #create' do
    let(:valid_attributes) do
      {
        user: {
          name: 'Test User',
          email: 'test@example.com',
          password: 'password123',
          password_confirmation: 'password123'
        }
      }
    end

    let(:invalid_attributes) do
      {
        user: {
          email: 'test@example.com',
          password: 'password123',
          password_confirmation: 'wrongpassword'
        }
      }
    end

    context 'with valid attributes' do
      it 'creates a new user' do
        expect {
          post :create, params: valid_attributes, format: :json
        }.to change(User, :count).by(1)
      end

      it 'returns a success response with a token' do
        post :create, params: valid_attributes, format: :json
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['status']['message']).to eq('Signed up successfully.')
        expect(JSON.parse(response.body)['data']['token']).to eq 'test-token'
        expect(JSON.parse(response.body)['data']['user']['email']).to eq 'test@example.com'
        expect(JSON.parse(response.body)['data']['user']['name']).to eq 'Test User'
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new user' do
        expect {
          post :create, params: invalid_attributes, format: :json
        }.not_to change(User, :count)
      end

      it 'returns an unprocessable entity response' do
        post :create, params: invalid_attributes, format: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['status']['message']).to include("User couldn't be created successfully.")
      end
    end
  end
end