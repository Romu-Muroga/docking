module PostsHelper
  def post_with_pictures_edit_page?(post)
    !(action_name == 'new' || action_name == 'create') && (action_name == 'edit' || action_name == 'update') && post.picture.present?
  end

  # 現在のページをハイライトする
  def cp(path)
    'current' if current_page?(path)
  end

  # ハッシュタグをリンク化する
  def render_with_hashtags(remarks)
    # gsub:第1引数に正規表現のパターンを指定してブロックを渡すと、パターンにマッチする部分をすべて取り出して繰り返しブロックを実行します。
    # マッチした部分はブロックの戻り値に置き換わり、新しい文字列が返ります。
    remarks.gsub(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/) { |word| link_to word, "/posts/hashtag/#{word.delete("#")}" }.html_safe
  end
end
