require 'rails_helper'

RSpec.describe 'Properties', type: :request do
  let(:property) { create(:property) }
  let(:user) { create(:user) }
  let(:valid_params) do
    {
      property: {
        name: Faker::Lorem.words(number: 5).join(' ').slice(0, 15),
        location: Faker::Address.street_address,
        city: 'Paris',
        description: Faker::Lorem.paragraphs.join(' '),
        area: 100,
        number_of_rooms: 6,
        number_of_bedrooms: 3,
      }
    }
  end

  let(:edit_params) do
    {
      property: {
        name: 'new name',
        location: Faker::Address.street_address,
        city: 'Paris',
        description: Faker::Lorem.paragraphs.join(' '),
        area: 100,
        number_of_rooms: 6,
        number_of_bedrooms: 3,
      }
    }
  end
  describe 'GET /properties' do
    it 'returns http success' do
      get '/properties'
      expect(response.status).to eq(200)
    end
  end

  describe 'GET /properties' do
    it 'returns http success' do
      get property_path(property)
      expect(response.status).to eq(200)
    end
  end

  describe 'POST /properties' do
    let!(:user) do
      User.create!(email: 'user@example.com', password: 'Password!23', first_name: 'Billie Joe', last_name: 'Armstrong')
    end

    context 'user is signed in' do
    skip()
      before do
        post '/users/sign_in', params: { user: { email: 'user@example.com', password: 'Password!23'} }
        @token = response.headers["authorization"]
      end

      it 'returns http response created' do
        post properties_path, params: valid_params, headers: { Authorization: @token }
        expect(response.status).to eq(201)
      end

      it 'creates a new property' do
        expect do
          post properties_path, params: valid_params, headers: { Authorization: @token }
        end.to change(Property, :count).by(1)
      end
    end

    context 'user is not signed in' do
      it 'returns http response unauthorized' do
        post properties_path, params: valid_params
        expect(response.status).to eq(401)
      end
    end
  end

  describe 'PATCH /property/:id' do
    let!(:user) do
      User.create!(email: 'user@example.com', password: 'Password!23', first_name: 'Billie Joe', last_name: 'Armstrong')
    end
    let(:property_edit) { create(:property, user: user) }

    context 'user is signed in' do
    skip()
      before do
        post '/users/sign_in', params: { user: { email: 'user@example.com', password: 'Password!23'} }
        @token = response.headers["authorization"]
      end

      it 'returns http response success' do
        patch property_path(property_edit), params: edit_params, headers: { Authorization: @token }
        expect(response.status).to eq(200)
        expect(Property.last.name).to eq('new name')
      end
    end
    context 'user is not signed in' do
      it 'returns http response unauthorized' do
        patch property_path(property_edit), params: edit_params
        expect(response.status).to eq(401)
      end
    end
  end

  describe 'DELETE /property/:id' do
    let!(:user) do
      User.create!(email: 'user@example.com', password: 'Password!23', first_name: 'Billie Joe', last_name: 'Armstrong')
    end

    context 'user is signed in' do
    skip()
      let(:property_delete) { create(:property, user: user) }
      let(:property_delete2) { create(:property, user: user) }

      before do
        post '/users/sign_in', params: { user: { email: 'user@example.com', password: 'Password!23'} }
        @token = response.headers["authorization"]
      end

      it 'deletes property' do
        property_count = Property.count
        delete property_path(property_delete2), headers: { Authorization: @token }
        expect(Property.count).to eq(property_count)
      end

      it 'returns http response success' do
        delete property_path(property_delete), headers: { Authorization: @token }
        expect(response.status).to eq(204)
      end
    end

    context 'user is not signed in' do
      let(:property_delete) { create(:property, user: user) }
      it 'returns http response unauthorized' do
        delete property_path(property_delete)
        expect(response.status).to eq(401)
      end
    end
  end
end

