module PostsHelper
  def post_with_pictures_edit_page?(post)
    !(action_name == 'new' || action_name == 'create') &&
      (action_name == 'edit' || action_name == 'update') && post.picture.present?
  end

  def choose_post
    t('.to_post') if action_name == 'new' || action_name == 'update'
  end

  def name_ja_or_name_en
    if I18n.locale == :ja
      :name_ja
    elsif I18n.locale == :en
      :name_en
    else
      :name_ja
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
