class Product < ActiveRecord::Base

	attr_accessible :title, :purchase_net_euro, :buy_now_gross, :delivery_cost, :delivery_dhl_gross


	validates :title, presence: true
	validates :title, length: {maximum: 150}
	validates :purchase_net_euro, :numericality => {:greater_than_or_equal_to => 0} #,:format => { :with => /\A\d+(?:\.\d{0,2})?\z/ }
	validates :buy_now_gross, :numericality => {:greater_than_or_equal_to => 0}
	validates :delivery_cost, :numericality => {:greater_than_or_equal_to => 0}
	validates :delivery_dhl_gross, :numericality => {:greater_than_or_equal_to => 0}

	def self.importCSV
		lines = 0
		CSV.foreach('app/helpers/products_db.csv') do |row|
			lines += 1
			if row[1].blank? || lines < 3
				next
			end
			_title = row[1]
			#puts _title
			_purchase_net_euro = BigDecimal.new(row[2],2)
			#puts _purchase_net_euro
			_buy_now_gross = BigDecimal.new(row[5],2)
			_delivery_cost = BigDecimal.new(row[6],2)
			_delivery_dhl_gross = BigDecimal.new(row[8],2)
			Product.create!(title: _title, purchase_net_euro: _purchase_net_euro, buy_now_gross: _buy_now_gross, delivery_cost: _delivery_cost, delivery_dhl_gross: _delivery_dhl_gross)
			#prod = Product.new(title: _title, purchase_net_euro: _purchase_net_euro, buy_now_gross: _buy_now_gross, delivery_cost: _delivery_cost, delivery_dhl_gross: _delivery_dhl_gross)
			break if lines > 200
		end
	end

end