class Property < ApplicationRecord
  has_many_attached :images

  validates :name, presence: true, length: { maximum: 20 }
  validates :city, presence: true
  validates :price, presence: true,
            numericality:
            { only_integer: true, greater_than_or_equal_to: 1 }
  validates :location, presence: true
  validates :description, presence: true, length: { maximum: 500 }
  validates :area,
            presence: true,
            numericality:
            { only_integer: true, greater_than_or_equal_to: 10 }
  validates :number_of_rooms,
            presence: true,
            numericality:
            { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 90 }
  validates :number_of_bedrooms,
            presence: true,
            numericality:
            { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 90 }

  has_one :user_property, dependent: :destroy
  has_one :user, through: :user_property
end
