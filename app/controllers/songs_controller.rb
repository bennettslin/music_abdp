class SongsController < ApplicationController

  def related_artist
    artist = RSpotify::Artist.search('Sam Smith')
    #search term variable
    artist.each do |x|
      @id = x.id
      return @related_artists unless @related_artists.nil?
      data = RSpotify.get("artists/#{@id}/related-artists")
      @related_artists = data['artists'][0,2]

      # pass id into related artist string
      render :json => @related_artists
    end
  end

end
