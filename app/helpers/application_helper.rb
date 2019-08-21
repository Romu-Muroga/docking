module ApplicationHelper
  include SessionsHelper
  # Highlight current link
  def cp(path)
    'current' if current_page?(path)
  end

  def posts_index_page?(target_controller, target_action)
    'current' if target_controller == 'posts' &&
                 (target_action == 'index' || target_action == 'search')
  end

  def my_page?(target_controller, target_action)
    'current' if target_controller == 'users' && target_action == 'show'
  end

  # リンク付き画像(Post)
  def post_picture_link(post)
    if post.picture.present?
      link_to post_path(post) do
        image_tag(post.picture.image.url, class: 'img-responsive')
      end
    else
      link_to post_path(post) do
        image_tag('/images/default2.jpg', class: 'img-responsive')
      end
    end
  end

  # リンク付き画像(User)
  def user_picture_link(user)
    if user.picture.present?
      link_to user_path(user) do
        image_tag(user.picture.image.url, class: 'img-responsive')
      end
    else
      link_to user_path(user) do
        image_tag('/images/default.png', class: 'img-responsive')
      end
    end
  end

  # リンク無し画像(Post and User)
  def picture_not_link(instance)
    if instance.picture.present?
      image_tag(instance.picture.image.url, class: 'img-responsive')
    elsif instance.class == User
      image_tag('/images/default.png', class: 'img-responsive')
    else
      image_tag('/images/default2.jpg', class: 'img-responsive')
    end
  end

  # Link hashtags
  def render_with_hashtags(remarks)
    # gsub:第1引数に正規表現のパターンを指定してブロックを渡すと、パターンにマッチする部分をすべて取り出して繰り返しブロックを実行します。
    # マッチした部分はブロックの戻り値に置き換わり、新しい文字列が返ります。
    remarks.gsub(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/) { |word| link_to word, "/posts/hashtag/#{word.tr('＃', '#').delete('#')}" }.html_safe
  end
end
