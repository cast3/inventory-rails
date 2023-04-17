class CreateMovimientos < ActiveRecord::Migration[7.0]
  def change
    create_table :movimientos do |t|
      t.integer :tipo
      t.integer :cantidad
      t.string :descripcion
      t.references :product, null: false, foreign_key: true
      t.references :client,

      t.timestamps
    end
  end
end
