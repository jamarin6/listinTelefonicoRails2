class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :nombre
      t.string :ap1
      t.string :ap2
      t.date :fechaNac
      t.integer :padre_id

      t.timestamps
    end
  end
end
