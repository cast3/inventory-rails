json.extract! client, :id, :nombre, :apellido, :email, :telefono, :direccion, :created_at, :updated_at
json.url client_url(client, format: :json)
