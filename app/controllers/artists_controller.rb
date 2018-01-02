class ArtistsController < ApplicationController
  def new
    @artist = Artist.new
    # @search_results = @artist.allmusic_search_url
  end

  def create
    @url = allmusic_search_url(params[:name]).to_s
    if Artist.find_by(scrape_path: @url)
      @artist = Artist.find_by(scrape_path: @url)
    else
      @artist = Artist.create(scrape_path: @url)
    end
    redirect_to artist_path(@artist)
  end

  def add_artist
    @format = params[:format].to_i
    @artist = Artist.find_by(id: @format)
    @user = current_user
    @user.artists << @artist
    redirect_to root_url
  end

  def show
    @user = current_user
    @artist = Artist.find(params[:id])
    @artist_page = Nokogiri::HTML(open(@artist.scrape_path))
    # artist info
    @artist_name = @artist_page.css("h1.artist-name").text
    @artist.update(name: @artist_name)
    @artist_headline = @artist_page.css("p.biography span").text
    @artist.update(headline: @artist_headline)
    @artist_dates = @artist_page.css("div.active-dates").text
    @artist.update(years_active: @artist_dates)
    @artist_genre = @artist_page.css("div.genre a").text
    @artist_styles =  @artist_page.css("div.styles div a").map {|t| t.text}
    @artist_styles.each do |style|
      artist_style = Genre.find_or_create_by(name: style)
      @artist.genres << artist_style
      @artist.genres
    end
    @artist_similar = Nokogiri::HTML(open(@artist.scrape_path+"/related")).css("section.related.similars ul li a").map {|s| s.text}
    @artist_influence = Nokogiri::HTML(open(@artist.scrape_path+"/related")).css("section.related.influencers ul li a").map {|s| s.text}
    @artist_bio = Nokogiri::HTML(open(@artist.scrape_path+"/biography")).css("section.biography div.text")
    @artist.update(biography: @artist_bio)
  end

  def update
    @artist = Artist.find_or_create_by(artist_params)
  end

  private

  def artist_params
    params.require(:artist).permit(:name, :scrape_path, :years_active, :headlines, :biography, user_ids:[], user_attributes:[:username], genre_ids: [], genre_attributes:[:name])
  end

  def allmusic_search_url(band_name)
    name_url = band_name.split.join("+")
    band_name_search = "https://www.allmusic.com/search/artists/#{name_url}"
    puts "Loading: " + band_name_search
    Nokogiri::HTML(open(band_name_search)).css("div.name a")[0].attribute("href")
  end




end


#
#   @artists = Artist.new(name: params[:query])
#   @search_results = @artist.allmusic_search_url
#   redirect_to search_artists_path(params[:query])
# end
#
# def show
# end
