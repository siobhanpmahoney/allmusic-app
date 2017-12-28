require 'byebug'

class ArtistsController < ApplicationController

  def search
    @artist = Artist.new
    # @search_results = @artist.allmusic_search_url
  end

  def search_results
    @artist = Artist.create(name: artist_params[:name])
    puts @artist
    redirect_to artists_path
  end

  def index
    @artist = Artist.all.last
    puts @artist.name
    @search_results = @artist.allmusic_search_url
    puts @search_results
  end

  def show
  end

  private

  def artist_params
      params.require(:artist).permit(:name)
    end

    def allmusic_search_url
      name_url = self.search.split.join("+")
      band_name_search = "https://www.allmusic.com/search/artists/#{name_url}"
      Nokogiri::HTML(open(band_name_search))
    end

    def band_page_scrape


end


#
#   @artists = Artist.new(name: params[:query])
#   @search_results = @artist.allmusic_search_url
#   redirect_to search_artists_path(params[:query])
# end
#
# def show
# end
