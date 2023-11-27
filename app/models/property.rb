class Property < ApplicationRecord
  has_many_attached :images
  has_one :user_property
  has_one :user, through: :user_property
end
