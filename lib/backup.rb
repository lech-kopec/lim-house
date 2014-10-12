require 'open-uri'
require 'pp'
clear_front =''
clear_end = ''
all = []

open('http://allegro.pl/listing/user/listing.php?us_id=9342968') do |f|
  # hash with meta information
  #pp  f.meta

  #
  #pp "Content-Type: " + f.content_type
  #pp "last modified" + f.last_modified.to_s

  no = 1
  # print the first three lines
  f.each do |line|
    #print "#{no}: #{line}"
    if(line.match("<h2><a href"))
      clear_front = line.gsub(/(...)*<span>/,'')
      clear_end = clear_front.gsub(/<\/span>(...)*/,'')
      clear_end = clear_end.strip
      all << clear_end
      no = no + 1
      break if no == 2
    end
  end
end
#all.each { |i| p i }
#p all.length
p all[0]



descr.gsub(/(\r\n)+/,'\r\n')
