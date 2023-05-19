class Category < ApplicationRecord
  has_many :products
  validates :nombre, presence: true, uniqueness: true
end
