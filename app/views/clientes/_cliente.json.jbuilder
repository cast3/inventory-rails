json.extract! cliente, :id, :cedula, :nombre, :telefono, :correo, :created_at, :updated_at
json.url cliente_url(cliente, format: :json)
