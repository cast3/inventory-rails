categories = ['Despensa', 'Cuidado Personal', 'Belleza', 'Lácteos,Huevos Y Refrigerados', 'Vinos YLicores', 'Pasabocas',
              'Frutas YVerduras', 'Aseo DeHogar', 'Dulces YPostres', 'Panadería YPastelería', 'Limpieza DeCocina', 'Bebidas', 'Mascotas', 'Cuidado DeRopa Y Calzado', 'Platos Preparados', 'Carne Y Pollo', 'Cuidado DelBebé', 'Pescados YMariscos', 'Charcutería', 'Bolsas', 'Mundo Parrilla', 'Anchetas']

default_image_path = Rails.root.join('app', 'assets', 'images', 'default.png')
default_image = File.open(default_image_path, 'rb').read
image = Base64.encode64(default_image)

categories.each do |category|
  categoria = Category.new
  categoria.nombre = category
  categoria.save
end

50.times do |_n|
  proveedores = Provider.new
  proveedores.nombre = Faker::Name.name
  proveedores.telefono = 123_414_124_1
  proveedores.direccion = Faker::Address.full_address
  proveedores.email = Faker::Internet.email
  proveedores.save
end

50.times do |_n|
  productos = Product.new
  productos.nombre = Faker::Name.name
  productos.image = image
  productos.referencia = Faker::Number.number(digits: 10)
  productos.tipo = Product::TYPES[rand(0..1)]
  productos.fecha_caducidad = productos.tipo == 'Perecedero' ? Faker::Date.forward(days: 23) : nil
  productos.precio = Faker::Number.decimal(l_digits: 2)
  productos.category_id = rand(1..categories.length)
  productos.save
end

50.times do |_n|
  clientes = Client.new
  clientes.cedula = Faker::Number.number(digits: 10)
  clientes.nombre = Faker::Name.name
  clientes.telefono = Faker::Number.number(digits: 10)
  clientes.puntaje = 0
  clientes.save
end

user_Admin = User.new
user_Admin.email = 'admin@test.com'
user_Admin.password = 'admin123'
user_Admin.password_confirmation = 'admin123'
user_Admin.role = 'admin'
user_Admin.save

puts 'Seed finalizado'