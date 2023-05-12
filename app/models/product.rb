class Product < ApplicationRecord

  TYPES = %w[Perecedero Duradero].freeze
  before_save :upcase_referencia
  has_one :inventory, dependent: :destroy
  belongs_to :category

  validates :nombre, presence: true, length: { maximum: 50 }
  validates :referencia, presence: true, length: { maximum: 15 }
  validates :precio, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :tipo, presence: true, inclusion: { in: TYPES }
  validates :fecha_caducidad, if: :perecedero?, presence: true

  private

  def perecedero?
    tipo == 'Perecedero'
  end

  def upcase_referencia
    self.referencia = referencia.upcase
  end
end
