class AddNameEnToCategories < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :name_en, :string, limit: 500
  end
end
