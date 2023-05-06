class ProductPerishable < Product
  validates :fecha_caducidad, presence: true

  scope :proximos_a_caducar, -> { where('fecha_caducidad <= ?', Date.today + 1.week) }
end
