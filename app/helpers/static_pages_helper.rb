module StaticPagesHelper

	My_max = 560

	def shorten_description(descr)
		result = " "
		new_line_pos = 0
		if descr.length > My_max
			6.times do |i|
				new_line_pos = descr.index(/\n/,new_line_pos.to_i+1)
			end
			if new_line_pos == nil || new_line_pos > My_max
				new_line_pos = My_max
			end
			result = descr[0..new_line_pos] << "..."
		else
			result = descr
		end
		result
	end
				
end
