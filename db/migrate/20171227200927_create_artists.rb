class CreateArtists < ActiveRecord::Migration[5.1]
  def change
    create_table :artists do |t|
      t.string :name
      t.string :scrape_path
      t.string :years_active
      t.string :headline
      t.text :biography

      t.timestamps
    end
  end
end
