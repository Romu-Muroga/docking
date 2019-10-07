module UsersHelper
  def Create_account_page?
    action_name == 'new' || action_name == 'confirm' || action_name == 'create'
  end

  def Edit_account_setting_page?
    action_name == 'edit' || action_name == 'update'
  end

  def choose_confirm_or_update
    if action_name == 'new' || action_name == 'confirm' || action_name == 'create'
      'confirm'
    elsif action_name == 'edit' || action_name == 'update'
      'update'
    end
  end

  def choose_confirm_screen_or_update_account_setting
    if action_name == 'new' || action_name == 'confirm' || action_name == 'create'
      t('.to_confirm_page')
    elsif action_name == 'edit' || action_name == 'update'
      t('.update_account_setting')
    end
  end

  def choose_the_button_color
    if action_name == 'new' || action_name == 'confirm' || action_name == 'create'
      "btn btn-default"
    elsif action_name == 'edit' || action_name == 'update'
      "btn btn-primary"
    end
  end

  def choose_name_ja_or_name_en(category)
    if I18n.locale == :ja
      category.name_ja
    elsif I18n.locale == :en
      category.name_en
    else
      category.name_ja
    end
  end
end
