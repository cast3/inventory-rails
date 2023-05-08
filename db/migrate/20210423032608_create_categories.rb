class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|
      t.string :nombre

      t.timestamps
    end
    add_index :categories, :nombre, unique: true
  end
end
