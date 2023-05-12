class CreateMovements < ActiveRecord::Migration[7.0]
  def change
    create_table :movements do |t|
      t.references :inventory, foreign_key: true, null: false
      t.references :client, null: true,  default: nil, foreign_key: true
      t.references :provider, null: true, default: nil, foreign_key: true
      t.integer :tipo_movimiento
      t.text :descripcion
      t.integer :cantidad

      t.timestamps
    end
    add_index :movements, %i[inventory_id tipo_movimiento], name: :index_movements_on_inventory_and_tipo_movimiento
  end
end
