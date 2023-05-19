class Perishable < Product
  # Validaciones
  validates :fecha_caducidad, :presence => true

  # Métodos
  def tipo
    super + ' Perecedero'
  end
end
