include ActionDispatch::TestProcess
FactoryGirl.define do
	factory :user do
		name "test"
		#email "test@example.com"
		sequence(:email) {|n| "it@it#{n}.com"}
		password "passwd"
		password_confirmation "passwd"
	end
	factory :product do
		title "test_title"
		purchase_net_euro 10
		buy_now_gross 20
		delivery_cost 3
		delivery_dhl_gross 3
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
		auction_date (Date.current - 1.day)
		status 1
		#image { fixture_file_upload(Rails.root.join('spec', 'images', 'test.jpg'), 'image/jpg') }
		user
	end
	factory :comment do
		content "Tresc komentarza pracownika"
		prod_return
		user
	end
end