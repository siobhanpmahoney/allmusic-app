class User < ApplicationRecord
  has_secure_password
  has_many :user_artists
  has_many :artists, through: :user_artists
  accepts_nested_attributes_for :artists

  def liked_artists
    self.artists
  end

  def fav_artist?(artist)
    self.liked_artists.include?(artist)
  end

  # def add_artist(artist)
  #   artist = Artist.find(artist[:id])
  #   self.artists << artist
  # end


  def artist_attributes=(artist_attributes)
    artist_attributes.values.each do |artist_attribute|
      artist = Artist.find_or_create_by(artist_attribute)
      self.artists << artist
    end
  end

  def user_genres
    genres = []
    self.artists.each do |artist|
      artist.genres.each do |genre|
        genres << genre
      end
    end
    genres.uniq
  end

end
