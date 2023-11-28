
require_dependency 'validators/password_regex_validator'

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  include Devise::JWT::RevocationStrategies::JTIMatcher
  devise :database_authenticatable, :registerable,
         :validatable, :jwt_authenticatable, jwt_revocation_strategy: self

  has_many :user_properties, dependent: :destroy
  has_many :properties, through: :user_properties, dependent: :destroy

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates_with Validators::PasswordRegexValidator

  validates :first_name, presence: true
  validates :last_name, presence: true
end
