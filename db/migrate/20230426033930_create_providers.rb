class CreateProviders < ActiveRecord::Migration[7.0]
  def change
    create_table :providers do |t|
      t.string :nombre
      t.string :direccion
      t.string :telefono
      t.string :email

      t.timestamps
    end
  end
end
