class Entrada < Movement
  def aplicar(inventario)
    inventory.agregar_producto(Product.new(@product.id, @product.nombre, @product.descripcion, @cantidad,
                                            @product.precio_compra))
  end

  def to_s
    "Entrada - #{@product} - Cantidad: #{@cantidad} - Fecha: #{@fecha}"
  end
end
