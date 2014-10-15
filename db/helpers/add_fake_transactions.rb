auctions = Auction.limit(3)
auction = auctions[1]
auction2 = auctions[2]
Client.limit(5).each do |cl|
	cl.transactions.build(auction_id:auction.id, status:0, quantity:1)
	cl.save
	cl.transactions.build(auction_id:auction2.id, status:0, quantity:2)
	cl.save
end