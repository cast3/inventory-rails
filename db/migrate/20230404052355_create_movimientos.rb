class CreateMovimientos < ActiveRecord::Migration[7.0]
  def change
    create_table :movimientos do |t|
      t.string :tipo
      t.references :cliente, null: true
      t.datetime :fecha

      t.timestamps
    end
  end
end
