class CreateClients < ActiveRecord::Migration[7.0]
  def change
    create_table :clients do |t|
      t.string :cedula, primary_key: true
      t.string :nombre
      t.string :telefono
      t.string :email
      t.integer :puntaje

      t.timestamps
    end
  end
end
