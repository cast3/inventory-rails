class Movimiento < ApplicationRecord
  has_many :movimientos_productos
  has_many :products, through: :movimientos_productos
  belongs_to :cliente
  enum tipo: { entrada: 'entrada', salida: 'salida' }

  validates :tipo, presence: true

  after_save :actualizar_stock_producto

  def actualizar_stock_producto
    movimientos_productos.each do |movimiento_producto|
      if entrada?
        movimiento_producto.product.sumar_stock(movimiento_producto.cantidad)
      else
        movimiento_producto.product.restar_stock(movimiento_producto.cantidad)
      end
    end
  end
end
