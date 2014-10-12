def shrt(descr)
		my_max = 360
		result = " "
		new_line_pos = 0
		if descr.length > my_max
			2.times do |i|
				new_line_pos = descr.index(/\n/,new_line_pos+1)
				p new_line_pos
			end
			if new_line_pos == nil
				new_line_pos = my_max
			end
			result = descr[0..new_line_pos] << "..."
		else
			result = descr
		end
		p new_line_pos
		result
end