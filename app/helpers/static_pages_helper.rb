module StaticPagesHelper

		My_max = 450
	def shorten_description(descr)
		if descr.length > My_max
			result = descr[0..My_max] << "..."
		else
			result = descr
		end
		result
	end
end
