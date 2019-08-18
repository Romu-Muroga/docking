module ApplicationHelper
  # Highlight current page
  def cp(path)
    'current' if current_page?(path)
  end
end
