json.extract! product, :id, :nombre, :referencia, :fecha_expiracion, :provider_id, :category_id, :created_at,
              :updated_at
json.url product_url(product, format: :json)
