module ItemsHelper
	def draw_item(item)
		html = image_tag item.photo.url(:medium)
        html += "<p class='item-title'>#{ item.title }</p>".chop.html_safe
        html.html_safe
    end
end
