class AddAdminColumnUsers < ActiveRecord::Migration[5.2]
  def up
    add_column :users, :admin, :boolean, default: false, null: false
  end

  def down
    remove_column :users, :admin, :boolean
  end
end
