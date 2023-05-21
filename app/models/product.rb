class Product < ApplicationRecord
  before_save :upcase_referencia, :capitalize, :tipo
  has_one :inventory, dependent: :destroy
  belongs_to :category

  validates :nombre, presence: true, length: { maximum: 50 }
  validates :referencia, presence: true, length: { maximum: 15 }
  validates :precio, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def tipo
    self.tipo = 'Producto'
  end

  private

  def upcase_referencia
    self.referencia = referencia.upcase
  end

  def capitalize
    self.nombre = nombre.downcase.capitalize
  end
end
