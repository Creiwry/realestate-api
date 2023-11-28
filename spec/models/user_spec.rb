# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  puts 'User Loaded'
  before do
    create(:user)
  end

  it { should have_many(:user_properties).dependent(:destroy) }
  it { should have_many(:properties).through(:user_properties) }

  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_uniqueness_of(:email).case_insensitive }
  it { should allow_value('example@example.com').for(:email) }
  it { should_not allow_value('bad_email').for(:email) }

  it 'should be valid when password meets criteria' do
    user = User.new(password: 'Good$123')
    user.valid?
    expect(user.errors[:password]).to be_empty
  end

  it 'should be invalid when password is bad' do
    user = User.new(password: 'badpass')
    user.valid?
    expect(user.errors[:password]).to include('should have more than 6 characters including 1 uppercase letter, 1 number, 1 special character')
  end
end
