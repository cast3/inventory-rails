class Category < ApplicationRecord
  belongs_to :product
  validates :nombre, presence: true
end
