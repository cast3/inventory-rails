class CreateClients < ActiveRecord::Migration[7.0]
  def change
    create_table :clients do |t|
      t.string :nombre
      t.string :apellido
      t.string :email
      t.string :telefono
      t.string :direccion

      t.timestamps
    end
  end
end
