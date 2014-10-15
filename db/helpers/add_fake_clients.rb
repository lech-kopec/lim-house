
31.times do |i|
	cl = Client.new(f_name:"john#{i}", l_name:"doe#{i}", address:"#{i}road#{i}")
	cl.save
end