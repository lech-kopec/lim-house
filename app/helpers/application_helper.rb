module ApplicationHelper
	
	ReturnsStatus = { przyjete:1, przetworzone:2, zwrot_gotowki: 4, wymiana: 5, wyslane:3, archiwum:99, zamknij_usun:0 }.freeze

	def full_title(page_title)
		base_title = "Lim-House"
		if page_title.empty?
			base_title
		else
			"#{base_title} | #{page_title}"
		end
	end
	def generate_status_message(status)
		if status == 1
			"Przesylka dotarla, wszystko sie zgadza. Czeka na wyslanie"
		elsif status == 2
			"Przesylka wyslana"
		elsif status == 3
			"Zwrot zamkniety i przeniesiony do archiwum"
		elsif status == 4
			"Gotowka wyslana"
		elsif status == 5
			"Wymieniony wyslany"
		elsif status == 99
			"Do archiwum"
		end
	end
	def next_status(status)
		if status == 1
			ApplicationHelper::ReturnsStatus.key(2)
		elsif status == 2
			ApplicationHelper::ReturnsStatus.key(3)
		elsif status == 3
			ApplicationHelper::ReturnsStatus.key(99)
		else
			ApplicationHelper::ReturnsStatus.key(3)
		end
	end
end
