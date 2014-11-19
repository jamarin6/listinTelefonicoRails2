class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :nombre
      t.integer :numTlf
      t.references :user

      t.timestamps
    end
    add_index :contacts, :user_id
  end
end
