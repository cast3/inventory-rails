class Inventory < ApplicationRecord
  include PgSearch::Model

  pg_search_scope :search_by_name, against: [:stock], using: {
    tsearch: {
      dictionary: "spanish",
      any_word: true,
      prefix: true,
    }
  }

  belongs_to :product

  validates :stock, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :cantidad_minima, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  before_save :verificar_cantidad_disponible

  def proveedores
    Provider.joins(:inventories).where(inventories: { product_id: product.id })
  end

  private

  def verificar_cantidad_disponible
    return unless stock.negative?

    errors.add(:stock, 'No puede ser negativa')
    throw :abort
  end
end
