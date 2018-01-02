class CreateArtistGenres < ActiveRecord::Migration[5.1]
  def change
    create_table :artist_genres do |t|
      t.belongs_to :artist
      t.belongs_to :genre

      t.timestamps
    end
  end
end
