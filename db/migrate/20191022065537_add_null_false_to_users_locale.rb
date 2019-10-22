class AddNullFalseToUsersLocale < ActiveRecord::Migration[5.2]
  def change
    change_column_null :users, :locale, false
  end
end
