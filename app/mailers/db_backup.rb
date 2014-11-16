class DbBackup < ActionMailer::Base
	default from: "lech.kopec@gmail.com"

	def backup_email(prods, coms)
		@recipient = "biuro@lim-trade.pl"
		attachments['products.csv'] = prods
		attachments['comments.csv'] = coms
		mail(to: @recipient, subject:"Products and comments backup")
	end

end
