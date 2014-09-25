(1..16).each do |i|
	tit = "Prod#{i}"
	descr = "ProdDescr#{i}"*20
	pr = i
	st = (i % 4) + 1
	prod = Product.new(title:tit, description:descr, price: pr, status: st)
	prod.save(validate: false)
end