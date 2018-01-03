class CreateGenres < ActiveRecord::Migration[5.1]
  def change
    create_table :genres do |t|
      t.string :name
      t.string :genre_url
      t.text :description


      t.timestamps
    end
  end
end
