class Movement < ApplicationRecord
  belongs_to :inventory
  belongs_to :client, optional: true
  belongs_to :provider, optional: true

  MOVEMENT_TYPES = { add: 0, remove: 1 }.freeze

  validates :cantidad, presence: true
  validates :descripcion, presence: true, length: { maximum: 50 }
  validates :tipo_movimiento, presence: true, inclusion: { in: MOVEMENT_TYPES.values }
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

  def update_entrada(cantidad, provider_id)
    inventory = Inventory.find(inventory_id)
    inventory.update(stock: inventory.stock + cantidad)
  end

  def update_salida(cantidad, client_id)
    inventory = Inventory.find(inventory_id)
    inventory.update(stock: inventory.stock - cantidad)

    client = Client.find(client_id)
    if cantidad >= 50
      puntos = (cantidad / 50) * 10
      client.update(puntaje: client.puntaje + puntos)
    else
      puntos = (cantidad / 10) * 10
      puntos = 10 if puntos.zero?
      client.update(puntaje: client.puntaje + puntos)
    end
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
