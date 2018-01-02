class Artist < ApplicationRecord
  has_many :user_artists
  has_many :users, through: :users
  has_many :artist_genres
  has_many :genres, through: :artist_genres
  accepts_nested_attributes_for :users
  accepts_nested_attributes_for :genres


  def allmusic_search_url
    require 'open-uri'
    if self.name
      name_url = self.name.split.join("+")
      band_name_search = "https://www.allmusic.com/search/artists/#{name_url}"
      Nokogiri::HTML(open(band_name_search))
    end
  end

  def band_page_scrape
    self.scrape_path.css("div.name a")[0]. Nokogiri::HTML(open(attribute("href").value))
  end

  def user_attributes=(user_attributes)
    user_attributes.values.each do |user_attribute|
      user = User.find_or_create_by(user_attribute)
      self.users << user
    end
  end

  def genre_attributes=(genre_attributes)
    genre_attributes.values.each do |genre_attribute|
      genre = User.find_or_create_by(genre_attribute)
      self.genres << genre
    end
  end

end
