class Movimiento < ApplicationRecord
  belongs_to :product
  MOVEMENT_TYPES = { add: 0, remove: 1 }.freeze
  validates :cantidad, presence: true, numericality: true

  def self.get_movement_types
    {
      'Entrada' => MOVEMENT_TYPES[:add],
      'Salida' => MOVEMENT_TYPES[:remove]
    }
  end

  def movement_type_name
    return 'Entrada' if movement_type == MOVEMENT_TYPES[:add]
    return 'Salida' if movement_type == MOVEMENT_TYPES[:remove]

    'NA'
  end
end
