FactoryBot.define do
  factory :product do
    nombre { "MyString" }
    descripcion { "MyString" }
    cantidad { 1 }
    precio_compra { "9.99" }
  end
end
