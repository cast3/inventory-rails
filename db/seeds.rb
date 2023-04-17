require 'faker'

# 5.times do |_n|
#   categoria = Category.new
#   categoria.nombre = Faker::Name.name
#   categoria.save
# end

<<<<<<< HEAD
5.times do |_n|
  proveedores = Provider.new
  proveedores.nombre = Faker::Name.name
  proveedores.telefono = 11_234_141_241
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

5.times do |_n|
  clientes = Client.new
  clientes.nombre = Faker::Name.name
  clientes.telefono = 11_234_141_241
  clientes.direccion = Faker::Address.full_address
  clientes.save
end

5.times do |_n|
  movimiento = Movimiento.new
  movimiento.tipo = Movimiento::MOVEMENT_TYPES[:add]
  movimiento.cantidad = Faker::Number.number(digits: 2)
  movimiento.product = Product.all.sample
  movimiento.descripcion = Faker::Lorem.sentence(word_count: 3)
  movimiento.client = Client.all.sample
  movimiento.provider = Provider.all.sample
  movimiento.save
end
=======
# 5.times do |_n|
#   proveedores = Provider.new
#   proveedores.nombre = Faker::Name.name
#   proveedores.telefono = 1_234_141_241
#   proveedores.direccion = Faker::Address.full_address
#   proveedores.save
# end

# 5.times do |_n|
#   productos = Product.new
#   productos.nombre = Faker::Name.name
#   productos.referencia = Faker::Number.number(digits: 10)
#   productos.fecha_expiracion = Faker::Date.between(from: 1.year.ago, to: 1.year.from_now)
#   productos.provider = Provider.all.sample
#   productos.category = Category.all.sample
#   productos.save
# end

# 5.times do |_n|
#   movimiento = Movimiento.new
#   movimiento.tipo = Movimiento::MOVEMENT_TYPES[:add]
#   movimiento.cantidad = Faker::Number.number(digits: 2)
#   movimiento.product = Product.all.sample
#   movimiento.descripcion = Faker::Lorem.sentence(word_count: 3)
#   movimiento.save
# end
>>>>>>> 06c0dc7 (Cambios a diagrama)
