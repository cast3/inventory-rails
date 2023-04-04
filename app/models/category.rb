class Category < ApplicationRecord
  validates :nombre, presence: true, uniqueness: true
end
