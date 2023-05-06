class Inventory < ApplicationRecord
  belongs_to :product

  def initialize
    @products = {}
  end

  def agregar_producto(product)
    if @products.key?(product.id)
      @products[product.id].cantidad += product.cantidad
    else
      @products[product.id] = product
    end
  end

  def quitar_producto(id, cantidad)
    if @products.key?(id) && @products[id].cantidad >= cantidad
      @products[id].cantidad -= cantidad
      @products.delete(id) if @products[id].cantidad.zero?
    else
      puts 'No se pudo quitar el product. Verifique la cantidad o el ID.'
    end
  end

  def mostrar_inventario
    @products.values.each { |product| puts "#{product} - Cantidad: #{product.cantidad}" }
  end
end
