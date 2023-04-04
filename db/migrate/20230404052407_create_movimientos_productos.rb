class CreateMovimientosProductos < ActiveRecord::Migration[7.0]
  def change
    create_table :movimientos_productos do |t|
      t.references :movimiento, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.integer :cantidad

      t.timestamps
    end
  end
end
