class SongsController < ApplicationController

  # attr_accessor :genre

  def genre
    genre = RSpotify::Artist.search('genre:Pop', limit: 25)
    #search term variable
    genre.each do |x|
      @id = x.id
      return @genre unless @genre.nil?
      data = RSpotify.get("artists/#{@id}/related-artists")
      @genre = data['artists'][rand(0..24),3]
      # pass id into related artist string
      render :json => @genre
      # render :plain => @genre
      # render :json => RSpotify::Artist.search(@genre)
    end
  end
end