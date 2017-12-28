require 'nokogiri'
require 'open-uri'
require 'RestClient'
require 'HTTParty'
require 'pry'

#Nokogiri::HTML(open(vu)).css("div.info div.name a").map {|p| p.text }

def allmusic_search_url(bandname)
  name_url = bandname.split.join("+")
  band_name_search = "https://www.allmusic.com/search/artists/#{name_url}"
  Nokogiri::HTML(open(band_name_search))
end

# def search_results(bandname)
#   Nokogiri::HTML(open(allmusic_search_url(bandname_name_search)))
# end

##scrapes search results for
#Nokogiri::HTML(open(vu)).css("div.info div.name a").map {|p| p.text }

byebug

puts "hi"
