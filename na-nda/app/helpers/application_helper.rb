module ApplicationHelper
  def page_title
    title = "Na-nda"
    title = @page_title + " - " + title if @page_title
    title
  end

  def page_description
    description = "脳トレから暇つぶしまで使える「クイズ」を紹介してます。頭の体操や大人数で盛り上がってください。"
    description = @page_description + " - " + description if @page_description
    description
  end

  def menu_link_to(text, path)
    link_to_unless_current(text, path) { content_tag(:span, text) }
  end

  # 会員画像用のimgタグ
  def member_image_tag(member, options = {})
  	if member.image.present?
  		path = member_path(member, format: member.image.extension)
  		link_to(image_tag(path, {　alt: member.name }.merge(options)), path)
  	else
  		""
  	end
  end
end
