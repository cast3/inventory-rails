class Product < ApplicationRecord
  include PgSearch::Model

  pg_search_scope :search_by_name, against: [:nombre], using: {
    tsearch: {
      dictionary: 'spanish',
      any_word: true,
      prefix: true
    }
  }

  TYPES = %w[Perecedero Duradero].freeze
  has_many :movements, dependent: :destroy

  before_save :upcase_referencia
  has_one :inventory, dependent: :destroy
  has_one :provider, through: :inventory

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
