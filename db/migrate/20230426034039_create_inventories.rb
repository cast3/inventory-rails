class CreateInventories < ActiveRecord::Migration[7.0]
  def change
    create_table :inventories do |t|
      t.references :product, null: false, foreign_key: true
      t.integer :stock
      t.integer :cantidad_minima

      t.timestamps
    end
  end
end
