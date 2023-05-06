FactoryBot.define do
  factory :movement do
    movimiento_id { 1 }
    product { nil }
    tipo_movimiento { 1 }
    cantidad { 1 }
    fecha { "2023-04-28" }
  end
end
