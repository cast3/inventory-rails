class CreateClients < ActiveRecord::Migration[7.0]
  def change
    create_table :clients do |t|
      t.string :cedula
      t.string :nombre
      t.string :telefono
      t.integer :puntaje

      t.timestamps
    end
  end
end
