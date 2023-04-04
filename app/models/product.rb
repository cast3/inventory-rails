class Product < ApplicationRecord
  belongs_to :provider
  belongs_to :category
  has_many :movimientos_productos
  has_many :movimientos, through: :movimientos_productos

  validates :nombre, presence: true
  validates :referencia, presence: true
  validates :fecha_expiracion, presence: true
  validates :provider_id, presence: true
  validates :category_id, presence: true

  def sumar_stock(cantidad)
    self.stock += cantidad
    save
  end

  def restar_stock(cantidad)
    self.stock -= cantidad
    save
  end
end
