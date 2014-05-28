module ItemsHelper
	def draw_item(item)
		html = image_tag item.photo.url(:medium)
        html += "<br/>".html_safe + item.title
        html.html_safe
    end
end
