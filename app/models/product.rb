class Product < ApplicationRecord
  belongs_to :provider
  belongs_to :category

  validates :nombre, presence: true
  validates :referencia, presence: true
  validates :fecha_expiracion, presence: true
  validates :provider_id, presence: true
  validates :category_id, presence: true
end
