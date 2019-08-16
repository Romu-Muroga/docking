module PicturesHelper
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
end
