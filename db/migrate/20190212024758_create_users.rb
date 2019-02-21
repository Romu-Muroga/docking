class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name, null: false, limit: 500
      t.string :email, null: false, limit: 500
      t.string :password_digest, null: false, limit: 100
      t.timestamps
    end
  end
end
