FactoryBot.define do
  factory :product do
    nombre { Faker::Name.first_name }
    referencia { Faker::Lorem.sentence(word_count: 1, supplemental: true) }
    precio { Faker::Number.decimal(l_digits: 2) }
   #category_id { association(:category) }
    created_at { Time.now }
    updated_at { Time.now }
  end
end
