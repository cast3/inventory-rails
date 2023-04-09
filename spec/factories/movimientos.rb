FactoryBot.define do
  factory :movimiento do
    tipo { 1 }
    cantidad { 1 }
    descripcion { "MyString" }
    product { nil }
  end
end
