class Perishable < Product
  # Validaciones
  validates :fecha_caducidad, :presence => true, :if => :perishable?

  # Métodos
  def tipo
    super + ' Perecedero'
  end
end
