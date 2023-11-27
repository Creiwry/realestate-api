# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Property, type: :model do
  before do
    create(:property)
  end

  it { should respond_to(:images) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:city) }
  it { should validate_presence_of(:location) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:area) }
  it { should validate_presence_of(:number_of_rooms) }
  it { should validate_presence_of(:number_of_bedrooms) }

  it { should validate_length_of(:name).is_at_most(20) }
  it { should validate_length_of(:description).is_at_most(500) }

  describe 'attached images' do
    let(:property) { create(:property) }
    it 'can have attached images' do
      file = fixture_file_upload(Rails.root.join('spec', 'fixtures', 'house.jpg'), 'image/jpg')
      property.images.attach(file)
      expect(property.images.attached?).to eq(true)
    end
  end
end
