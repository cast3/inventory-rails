class MovimientosProducto < ApplicationRecord
  belongs_to :movimiento
  belongs_to :product

  validates :cantidad, presence: true, numericality: { greater_than: 0 }
end
