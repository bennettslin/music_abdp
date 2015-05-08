class SongsController < ApplicationController

  attr_accessor :genre

  def genre
    genre = RSpotify::Artist.search('genre:Pop')
    #search term variable
    genre.each do |x|
      @id = x.id
      return @genre unless @genre.nil?
      data = RSpotify.get("artists/#{@id}/related-artists")
      @genre = data['artists'][0,3]

      # pass id into related artist string
      render :json => @genre
    end
  end

  def artist

  end

end
