def jump(x,y,d)
	if (x==y)
		return 0
	else
		temp = (y-x)/d
		if temp.kind_of? Float
			p "----------"
			result = temp.to_i+1
		else
			result = temp
		end
	end
	return result
end
