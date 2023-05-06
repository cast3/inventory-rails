json.extract! client, :id, :nombre, :email, :puntaje, :created_at, :updated_at
json.url client_url(client, format: :json)
