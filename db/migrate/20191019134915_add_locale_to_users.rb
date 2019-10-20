class AddLocaleToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :locale, :string, limit: 100
  end
end
