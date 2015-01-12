class RemoveSignInCountAndCurrentSignInAtAndLastSignInAtFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :sign_in_count
    remove_column :users, :current_sign_in_at
    remove_column :users, :last_sign_in_at
  end

  def down
    add_column :users, :last_sign_in_at, :datetime
    add_column :users, :current_sign_in_at, :datetime
    add_column :users, :sign_in_count, :integer
  end
end
