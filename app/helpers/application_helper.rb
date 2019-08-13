module ApplicationHelper
  # 現在のページをハイライトする
  def cp(path)
    'current' if current_page?(path)
  end
end
