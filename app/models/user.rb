class User < ApplicationRecord
  has_secure_password
  has_many :user_artists
  has_many :artists, through: :user_artists
  accepts_nested_attributes_for :artists

  def liked_artists
    user.artists
  end

  def artist_attributes=(artist_attributes)
    artist_attributes.values.each do |artist_attribute|
      artist = Artist.find_or_create_by(artist_attribute)
      self.artists << artist
    end
  end
end
