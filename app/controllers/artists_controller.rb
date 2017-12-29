class ArtistsController < ApplicationController


  def new
    @artist = Artist.new
    # @search_results = @artist.allmusic_search_url
  end

  def create
    @artist = Artist.find_or_create_by(name: params[:name])
    puts @artist
    redirect_to artist_path(@artist)
  end

  def show
    @user = current_user
    @artist = Artist.find(params[:id])

    @search_results = @artist.allmusic_search_url
    @artist_url = @search_results.css("div.name a")[0].attribute("href").value
    @artist_page = Nokogiri::HTML(open(@artist_url))
    # artist info
    @artist_name = @artist_page.css("h1.artist-name").text
    @artist_headline = @artist_page.css("p.biography span").text
    @artist_dates = @artist_page.css("div.active-dates").text
    @artist_genre = @artist_page.css("div.genre a").text
    @artist_styles =  @artist_page.css("div.styles div a").map {|t| t.text}
    @artist_similar = Nokogiri::HTML(open(@artist_url+"/related")).css("section.related.similars ul li a").map {|s| s.text}
    @artist_influence = Nokogiri::HTML(open(@artist_url+"/related")).css("section.related.influencers ul li a").map {|s| s.text}
    @artist_bio = Nokogiri::HTML(open(@artist_url+"/biography")).css("section.biography div.text")
    if @user.fav_artist?(@artist)
      flash.now.alert = '#{@artist.name} has been added to your favorite artists'
    end
  end

  def update
    @artist = Artist.find_or_create_by(artist_params)
  end

  private

  def artist_params
    params.require(:artist).permit(:name, user_ids:[], users_attributes:[:username])
  end

  def allmusic_search_url
    name_url = self.name.split.join("+")
    band_name_search = "https://www.allmusic.com/search/artists/#{name_url}"
    Nokogiri::HTML(open(band_name_search))
  end

  def band_page_scrape
    allmusic_search_url.css("div.name a")[0]. Nokogiri::HTML(open(attribute("href").value))
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
