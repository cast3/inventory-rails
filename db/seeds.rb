categories = ['Despensa', 'Cuidado personal', 'Belleza', 'Lácteos, Huevos y refrigerados', 'Vinos y licores', 'Pasabocas',
              'Fruta y verduras', 'Aseo de hogar', 'Dulces y postres', 'Panadería YPastelería', 'Limpieza de cocina', 'Bebidas', 'Mascotas', 'Cuidado de ropa y calzado', 'Platos preparados', 'Carne y pollo', 'Cuidado del Bebé', 'Pescados y mariscos', 'Charcutería', 'Bolsas', 'Mundo parrilla', 'Anchetas']

# categories.each do |category|
#   categoria = Category.new
#   categoria.nombre = category
#   categoria.save
# end

# 50.times do |_n|
#   proveedores = Provider.new
#   proveedores.nombre = Faker::Name.name
#   proveedores.telefono = 123_414_124_1
#   proveedores.direccion = Faker::Address.full_address
#   proveedores.email = Faker::Internet.email
#   proveedores.save
# end

50.times do |_n|
  clientes = Client.new
  clientes.cedula = Faker::Number.number(digits: 10)
  clientes.nombre = Faker::Name.name
  clientes.telefono = Faker::Number.number(digits: 10)
  clientes.puntaje = 0
  clientes.save
end

# default_image_path = Rails.root.join('app', 'assets', 'images', 'default.png')
# default_image = File.open(default_image_path, 'rb').read
# image = Base64.encode64(default_image)

# 50.times do |_n|
#   productos = Perishable.new
#   productos.nombre = Faker::Name.name
#   productos.image = image
#   productos.referencia = Faker::Number.number(digits: 10)
#   productos.fecha_caducidad = Faker::Date.forward(days: 23)
#   productos.precio = Faker::Number.number(digits: 5)
#   productos.category_id = rand(1..categories.length)
#   productos.save
# end


puts 'Seed finalizado'