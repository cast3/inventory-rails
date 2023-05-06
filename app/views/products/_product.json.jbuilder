json.extract! product, :id, :nombre, :referencia, :precio, :category_id, :provider_id, :image, :created_at, :updated_at
json.url product_url(product, format: :json)
