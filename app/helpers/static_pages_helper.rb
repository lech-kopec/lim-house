module StaticPagesHelper

	My_max = 260
	def shorten_description(descr)
		new_line_pos = 0
		if descr.length > My_max
			#find first new line character after My_max
			new_line_pos = descr.index("\n", My_max)
			result = descr[0..new_line_pos] << "..."
		else
			result = descr
		end
		result
	end
end
