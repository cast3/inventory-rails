# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :nombre
      t.text :referencia
      t.float :precio
      t.text :image
      t.string :tipo
      t.date :fecha_caducidad
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
