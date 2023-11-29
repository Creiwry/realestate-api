require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:valid_attributes) do
    {
      user: {
        email: 'user@example.com',
        password: 'Password!23',
        password_confirmation: 'Password!23',
        first_name: 'Billie Joe',
        last_name: 'Armstrong'
      }
    }
  end

  describe 'POST /users' do
    it 'creates a new user' do
      expect do
        post '/users', params: valid_attributes
      end.to change(User, :count).by(1)
    end
  end

  describe 'POST /users/sign_in' do
    let!(:user) do
      User.create!(email: 'user@example.com', password: 'Password!23', first_name: 'Billie Joe', last_name: 'Armstrong')
    end

    it 'signs in the user' do
      post '/users/sign_in', params: { user: { email: 'user@example.com', password: 'Password!23' } }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PUT /users' do
    let(:user) { create(:user, password: 'Password!23') }

    before do
      sign_in user
    end

    context 'with valid attributes' do
      it 'updates the user' do
        put user_registration_path, params: {
          user: {
            first_name: 'Gee',
            last_name: 'Way',
            current_password: 'Password!23',
          }
        }

        user.reload
        expect(user.first_name).to eq('Gee')
        expect(user.last_name).to eq('Way')
      end
    end

    context 'with invalid attributes' do
      it 'does not update the user without current_password' do
        put user_registration_path, params: {
          user: {
            first_name: 'New Name',
            email: 'newemail@example.com'
          }
        }

        user.reload
        expect(user.first_name).not_to eq('New Name')
        expect(user.email).not_to eq('newemail@example.com')
      end
    end
  end

  describe 'DELETE /users' do
    let!(:user) do
      User.create!(email: 'user@example.com', password: 'Password!23', first_name: 'Billie Joe', last_name: 'Armstrong')
    end

    before do
      post '/users/sign_in', params: { user: { email: 'user@example.com', password: 'Password!23' } }
      @token = response.headers["authorization"]
    end

    it 'returns http code success' do
      delete '/users', headers: { Authorization: @token }
      expect(response.status).to eq(200) 
    end
  end
end
