class Provider < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search, against: [:nombre], using: { tsearch: { prefix: true } }

  validates :nombre, presence: true
  validates :direccion, presence: true, length: { maximum: 60 }
  validates :telefono, presence: true, length: { maximum: 10 }
  validates :correo_electronico, presence: true, length: { maximum: 60 }

  # attr_accessor :nombre, :direccion, :telefono, :correo_electronico

  # def initialize(nombre, direccion, telefono, correo_electronico)
  #   super
  #   @nombre = nombre
  #   @direccion = direccion
  #   @telefono = telefono
  #   @correo_electronico = correo_electronico
  # end
end
