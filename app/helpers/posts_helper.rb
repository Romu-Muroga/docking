module PostsHelper
  def post_with_pictures_edit_page?(post)
    !(action_name == 'new' || action_name == 'create') && (action_name == 'edit' || action_name == 'update') && post.picture.present?
  end

  # 現在のページをハイライトする方法
  def cp(path)
    'current' if current_page?(path)
  end

  def render_with_hashtags(content)
    content.gsub(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/) { |word| link_to word, "/post/hashtag/#{word.delete("#")}" }.html_safe
  end
end
