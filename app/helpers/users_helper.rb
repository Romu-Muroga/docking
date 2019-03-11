module UsersHelper
  def user_with_pictures_edit_page?(user)
    !(action_name == 'new' || action_name == 'create') && (action_name == 'edit' || action_name == 'update') && user.picture.present?
  end
end
