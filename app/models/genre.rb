class Genre < ApplicationRecord
  has_many :artist_genres
  has_many :artists, through: :artist_genres
  accepts_nested_attributes_for :artists

  def genre_scrape
    Nokogiri::HTML(open(self.genre_url))
  end 
end
