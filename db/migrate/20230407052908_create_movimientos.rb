class CreateMovimientos < ActiveRecord::Migration[7.0]
  def change
    create_table :movimientos do |t|
      t.integer :tipo
      t.integer :cantidad
      t.string :descripcion
      t.references :product, null: false, foreign_key: true
      t.references :client, null: true, foreign_key: true
      t.references :provider, null: true, foreign_key: true
      t.timestamps
    end
    add_index :movimientos, :id, name: 'index_movimientos_on_id'
  end
end
