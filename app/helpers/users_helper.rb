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
end
