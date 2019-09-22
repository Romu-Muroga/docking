module PostsHelper
  def post_with_pictures_edit_page?(post)
    !(action_name == 'new' || action_name == 'create') &&
      (action_name == 'edit' || action_name == 'update') && post.picture.present?
  end

  def choose_post
    t('.to_post') if action_name == 'new' || action_name == 'update'
  end
end
