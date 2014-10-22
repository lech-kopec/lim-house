module ApplicationHelper
	
	ReturnsStatus = { key1:1, key2:2, key3:3 }.freeze

	def full_title(page_title)
		base_title = "Lim-House"
		if page_title.empty?
			base_title
		else
			"#{base_title} | #{page_title}"
		end
	end
	def generate_status_message(ret)
		if ret.status == 1
			"Przesylka dotarla, wszystko sie zgadza. Czeka na wyslanie"
		elsif ret.status==2
			"Przesylka wyslana"
		end
	end
end
