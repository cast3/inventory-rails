class Client < ApplicationRecord
  has_many :movements, dependent: :destroy
  has_many :products, through: :movements

  validates :nombre, presence: true
  validates :telefono, presence: true, length: { maximum: 10 }
  validates :cedula, presence: true, uniqueness: true, length: { maximum: 10 }
end
