class CreateClientes < ActiveRecord::Migration[7.0]
  def change
    create_table :clientes do |t|
      t.integer :cedula
      t.string :nombre
      t.string :telefono
      t.string :correo

      t.timestamps
    end
  end
end
