class Perishable < Product
  # Validaciones
  validates :fecha_caducidad, :presence => true

  # Métodos
  def tipo
    self.tipo='Producto Perecedero'
  end
end
