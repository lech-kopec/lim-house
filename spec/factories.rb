FactoryGirl.define do
	factory :user do
		name "test"
		email "test@example.com"
		password "passwd"
		password_confirmation "passwd"
	end
	factory :product do
		title "test_title"
		description "test_description"
		price 2.0
		status 1
		quantity 100
		#image_lnk "http://sphotos-h.ak.fbcdn.net/hphotos-ak-snc6/223869_465102820201819_79682000_n.jpg"
		#image_lnk "/assets/rails.png"
	end
	factory :auction do
		title "test_title_auction"
		description "test_description_auction"
		price 22.0
		status 2
		quantity 22
		store "lim-trade"
		product
	end
	factory :client do
		f_name "Janusz"
		l_name "Polak"
		address "Warszawka 2/3"
	end
	factory :prod_return do
		client_name "Michal"
		client_msg "Nie wygodne"
		sequence(:auction_name) { |n| "krzeslo_niewygodne_#{n}"}
		#auction_name "Uber krzeslo"
		auction_date Date.current
		status 1
		user
	end
	factory :comment do
		content "Tresc komentarza pracownika"
		prod_return
		user
	end
end