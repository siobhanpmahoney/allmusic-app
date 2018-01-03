class GenresController < ArtistsController

  def new
    @genre = Genre.new
  end

  def create
    @genre = Genre.create(genre_params)
  end

  def show
    @genre = Genre.find(params[:id])
    @genre_scraper = @genre.genre_scrape
    @genre.update(description: @genre_scraper.css("p.description").text)
    @explore_art = @genre_scraper.css("div.artist").map do |artist|
      artist.text
    end
    @explore_art.each do |artist|
      artist.strip!
      newart = Artist.find_or_create_by(name: artist)
      newart.update(scrape_path: newart.allmusic_search_url)
    end
  end

  private


  def genre_params
    params.require(:genre).permit(:name, :genre_url, artist_ids:[], artist_attributes:[:name])
  end
end
