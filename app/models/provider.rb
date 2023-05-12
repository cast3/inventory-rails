class Provider < ApplicationRecord
  has_many :products, through: :inventories
  has_many :movements, dependent: :destroy

  validates :nombre, presence: true
  validates :direccion, presence: true, length: { maximum: 60 }
  validates :telefono, presence: true, length: { maximum: 10 }
  validates :email, presence: true, length: { maximum: 60 }
end
