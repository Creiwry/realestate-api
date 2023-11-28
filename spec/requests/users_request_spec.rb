require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:valid_attributes) do
    {
      user: {
        email: 'user@example.com',
        password: 'Password!23',
        password_confirmation: 'Password!23',
        first_name: 'Gerard',
      }
    }
  end

  describe 'DELETE #destroy session' do
    let(:user) { create(:user) }
    before do
      sign_in user
    end

    it 'logs the user out' do
      delete destroy_user_session_path
      expect(controller.current_user).to be_nil
    end
  end

  describe 'POST /users/sign_up' do
    it 'creates a new user' do
      expect do
        post user_registration_path, params: valid_attributes
      end.to change(User, :count).by(1)

      expect(response).to redirect_to(users_path)
    end
  end

  describe 'POST /users/sign_in' do
    let!(:user) do
      User.create!(email: 'user@example.com', password: 'Password!23', first_name: 'Gerard', last_name: 'Way')
    end

    it 'signs in the user' do
      post user_session_path, params: { user: { email: 'user@example.com', password: 'Password!23' } }
      expect(response).to redirect_to(root_path)
    end
  end

  describe 'GET /users/sign_in' do
    it 'returns http success' do
      get new_user_registration_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /users/sign_up' do
    it 'returns http success' do
      get new_user_session_path
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
    let(:user) { create(:user) }

    before do
      sign_in user
    end

    it 'destroys the user' do
      expect do
        delete user_registration_path
      end.to change(User, :count).by(-1)
    end
  end
end
