module ItemsHelper
	def draw_item(item)
		html = image_tag item.photo.url(:medium)
        html += "<br/>" + item.title
        html.html_safe
    end
end
