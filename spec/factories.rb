FactoryGirl.define do
	factory :user do
		name "Szef"
		email "szef@example.com"
		password "passwd"
		password_confirmation "passwd"
	end
	factory :product do
		title "test_title"
		description "test_description"
		price 2.0
		status 1
		quantity 100
	end
end