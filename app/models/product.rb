class Product < ActiveRecord::Base
  attr_accessible :title, :purchase_net_euro, :buy_now_gross, :delivery_cost, :delivery_dhl_gross

  validates :title, presence: true
  validates :title, length: {maximum: 150}
  validates :purchase_net_euro, :buy_now_gross, :delivery_cost, :delivery_dhl_gross, :format => { :with => /\A\d+(?:\.\d{0,2})?\z/ }, :numericality => {:greater_than_or_equal_to => 0}

  def self.importCSV
  	lines = 0
  	CSV.foreach('app/helpers/products_db.csv') do |row|
	  	lines += 1
  		if row[1].blank? || lines < 3
  			next
  		end
  		_title = row[1]
  		_purchase_net_euro = row[2].to_f
  		#puts _purchase_net_euro
  		_buy_now_gross = row[5].to_f
  		_delivery_cost = row[6].to_f
  		_delivery_dhl_gross = row[8].to_f
	  	Product.create!(title: _title, purchase_net_euro: _purchase_net_euro, buy_now_gross: _buy_now_gross, delivery_cost: _delivery_cost, delivery_dhl_gross: _delivery_dhl_gross)
	  	break if lines > 5
  	end
  end
end