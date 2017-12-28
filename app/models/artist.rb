class Artist < ApplicationRecord
  has_many :user_artists
  has_many :users, through: :users

  def allmusic_search_url
    require 'open-uri'
    name_url = self.name.split.join("+")
    band_name_search = "https://www.allmusic.com/search/artists/#{name_url}"
    Nokogiri::HTML(open(band_name_search))
  end

end
