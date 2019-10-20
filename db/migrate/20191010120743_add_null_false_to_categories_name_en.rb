class AddNullFalseToCategoriesNameEn < ActiveRecord::Migration[5.2]
  def change
    change_column_null :categories, :name_en, false
  end
end
