class Salida < Movement
  def aplicar(inventario)
    inventory.quitar_producto(@product.id, @cantidad)
  end

  def to_s
    "Salida - #{@product} - Cantidad: #{@cantidad} - Fecha: #{@fecha}"
  end
end
