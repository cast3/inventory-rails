class Client < ApplicationRecord
  has_many :movements, dependent: :destroy
  has_many :products, through: :movements

  validates :nombre, presence: true
  validates :telefono, presence: true, length: { maximum: 10 }
  validates :puntaje, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
