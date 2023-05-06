class Product < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search, against: [:nombre], using: { tsearch: { prefix: true } }

  TYPES = %w[Perecedero Duradero].freeze
  has_many :movements, dependent: :destroy

  before_save :upcase_referencia

  validates :nombre, presence: true, length: { maximum: 50 }
  validates :referencia, presence: true, length: { maximum: 15 }
  validates :precio, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :tipo, presence: true, inclusion: { in: TYPES }
  validates :cantidad, presence: true, numericality: { greater_than_or_equal_to: 0 }

  private

  def cantidad
    total = 0
    movements.each do |movement|
      if movement.movement_type == Movement::MOVEMENT_TYPES[:add]
        total += movement.cantidad
      else
        total -= movement.cantidad
      end
    end
    total
  end

  def upcase_referencia
    self.referencia = referencia.upcase
  end

  def fifo
    cantidad * precio
  end
end
