class Movement < ApplicationRecord
  belongs_to :product, polymorphic: true
  MOVEMENT_TYPES = { add: 0, remove: 1 }.freeze

  validates :cantidad, numericality: { greater_than: 0 }
  validates :fecha, presence: true
  validate :provider_id_or_client_id_present

  def self.get_tipo_movimiento
    {
      'Entrada' => MOVEMENT_TYPES[:add],
      'Salida' => MOVEMENT_TYPES[:remove]
    }
  end

  def nombre_tipo_movimiento
    return 'Entrada' if tipo_movimiento == MOVEMENT_TYPES[:add]
    return 'Salida' if tipo_movimiento == MOVEMENT_TYPES[:remove]
  end

  private

  def provider_id_or_client_id_present
    if provider_id.blank? && client_id.blank?
      errors.add(:base, 'Debe proporcionar al menos un proveedor o un cliente')
    elsif provider_id.present? && client_id.present?
      errors.add(:base, 'No se puede proporcionar un proveedor y un cliente')
    end
  end
end
