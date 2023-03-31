FactoryBot.define do
  factory :product do
    nombre { "MyString" }
    referencia { "MyString" }
    fecha_expiracion { "2023-03-31 03:45:14" }
    provider { nil }
    category { nil }
  end
end
