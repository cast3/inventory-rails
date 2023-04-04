json.extract! movimiento, :id, :tipo, :fecha, :cliente_id, :created_at, :updated_at
json.url movimiento_url(movimiento, format: :json)
