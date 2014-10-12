require 'open-uri'
require 'pp'
clear_front =''
clear_end = ''
offert_links = []
params = {}


def gather_offert_links(url)
	all = []
	#open home page for user with listing of all offerts
	open(url) do |f|
		no = 1
		f.each do |line|
			#find lines with links to produkts and clean off html tags
			if(line.match("<h2><a href") && (no < 4 ) )
				clear_front = line.gsub(/(.*=")|("><span>.*)/,'')
				clear_end = clear_front.strip
			    #collect all links to array
				all << clear_end
				p clear_end
				no = no + 1
			    #break if no == 2
			end
			#find link for next page and go there (recursive)
=begin
			if (line.match("nast"))
				#clean html tag
				next_link = line.gsub(/(.*href=")|("><span>.*)/,'')
				tmp = gather_offert_links("http://allegro.pl#{next_link}")
				all = all + tmp
			end
=end
		end
	end
	all 	#return collected links
end

def clean_title(line)
	#clear fornt and back tags and \n
	line = line.gsub(/(.*">\s*)|(\\n)|(<.*)/,'')
	#clear front and back white spaces
	line = line.gsub(/(\A\s*)|(\s*\z)/,'')
	line
end

def parse_offer(url)
	params = { title:"", description:"", price: 0, status: 1, quantity: 1, web_link:"" }
	descr_line = 0
	line_helper = ""
	next_line = 0
	open(url) do |f|
		f.each do |line|
			#weblink
			if (line.match("<link rel=\"canonical\""))
				lnk_line = line.gsub(/(\A\s*)|(\s*\z)|(.*=")|(".*)/,'')
				params[:web_link] = lnk_line
				#p "weblink: #{lnk_line} "
			end
			#title
			if (line.match("<h1 itemprop"))
				if line.match("</h1>")
					ttl_line = clean_title(line)
					#p "title: #{ttl_line}"
					params[:title] = ttl_line
				else
					line_helper = line_helper << " " << line
					next_line = 1
					next
				end
			end
			if next_line == 1
				line_helper = line_helper << " " << line
				if line.match("</h1>")
					next_line = 0
					line_helper = clean_title(line_helper)
					#p "title: #{line_helper}"
					params[:title] = line_helper
					next
				end
			end
			#price
			if (line.match("itemprop=\"price\">"))
				price = line.match(/\d+,?\d?\d?\sz./)
				price = price[0].gsub(/\sz./,'')
				price = price.gsub(/,/,'.')
				params[:price] = price.to_f
			end
			#quantity
			if (line.match("itemprop=\"quantity\">"))
				quantity = line.match(/\d+/)
				params[:quantity] = quantity[0]
			end
			#description
			if (line.match("<fieldset id=\"user_field\""))
				descr_line = 1
				next
			end
			if descr_line == 1
				#descr = line.force_encoding('utf-8')
				descr = line.gsub(/<([^>])*>/,'')
				descr.gsub!(/(Zobacz.*)|(&nbsp;)/,'')
				descr.gsub!(/\r+/,"\r\n")
				#p descr
				#params[:description] = descr.strip
				params[:description] = descr
				descr_line = 0
			end
		end
	end
	params.delete(:web_link)
	prod = Product.new(params)
	prod.save!
end

offert_links = gather_offert_links('http://allegro.pl/listing/user/listing.php?us_id=9342968')

#for each link go inside and retrive offer info
#url = offert_links[0]


offert_links.each do |url|
	parse_offer("http://allegro.pl#{url}")
end
