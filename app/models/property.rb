class Property < ApplicationRecord
  has_one :user_property
  has_one :user, through: :user_property
end
