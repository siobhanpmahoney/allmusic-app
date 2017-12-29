class Artist < ApplicationRecord
  has_many :user_artists
  has_many :users, through: :users
  accepts_nested_attributes_for :users


  def allmusic_search_url
    require 'open-uri'
    name_url = self.name.split.join("+")
    band_name_search = "https://www.allmusic.com/search/artists/#{name_url}"
    Nokogiri::HTML(open(band_name_search))
  end

  def user_attributes=(user_attributes)
    user_attributes.values.each do |user_attribute|
      user = User.find_or_create_by(user_attribute)
      self.users << user
    end
  end

end
