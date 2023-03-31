# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'

5.times do |_n|
  categoria = Category.new
  categoria.nombre = Faker::Name.name
  categoria.save
end

5.times do |_n|
  proveedores = Provider.new
  proveedores.nombre = Faker::Name.name
  proveedores.telefono = Faker::PhoneNumber.phone_number
  proveedores.direccion = Faker::Address.full_address
  proveedores.save
end

5.times do |_n|
  productos = Product.new
  productos.nombre = Faker::Name.name
  productos.referencia = Faker::Number.number(digits: 10)
  productos.fecha_expiracion = Faker::Date.between(from: 1.year.ago, to: 1.year.from_now)
  productos.provider = Provider.all.sample
  productos.category = Category.all.sample
  productos.save
end
