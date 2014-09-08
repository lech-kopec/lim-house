FactoryGirl.define do
	factory :user do
		name "Szef"
		email "szef@example.com"
		password "passwd"
		password_confirmation "passwd"
	end
end