class Product < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search, against: [:name], using: { tsearch: { prefix: true } }

  belongs_to :category
  belongs_to :provider
  has_many :movements
  has_many :reports, through: :movements

  validate :image_size_validation

  validates :nombre, presence: true, length: { maximum: 50 }
  validates :referencia, presence: true, length: { maximum: 50 }
  validates :precio, presence: true, numericality: { greater_than: 0 }

  attr_accessor :nombre, :precio, :descripcion, :referencia, :image, :category_id, :provider_id

  def tipo
    if is_a?(ProductoPerecedero)
      'Perecedero'
    elsif is_a?(ProductoDuradero)
      'Duradero'
    else
      'No definido'
    end
  end

  private

  def image_size_validation
    errors[:image] << 'debe ser menor a 5MB' if image.attached? && image.byte_size > 5.megabytes
  end
end
