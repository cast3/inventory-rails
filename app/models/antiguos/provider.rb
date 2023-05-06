class Provider < ApplicationRecord
  validates :nombre, presence: true, uniqueness: true
  validates :direccion, presence: true, length: { maximum: 50 }
  validates :telefono, presence: true, length: { minimum: 10 }
end
