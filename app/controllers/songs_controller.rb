class SongsController < ApplicationController
  require 'rspotify'

  def artist
    artist = RSpotify::Artist.search('Sam Smith')
    #search term variable
    artist.each do |x|
      @id=x.id
      return @related_artists unless @related_artists.nil?
      # json = RSpotify.get("artists/7Ln80lUS6He07XvHI8qqHH/related-artists")
      json = RSpotify.get("artists/#{@id}/related-artists")
      @related_artists = json['artists'][0,2]

# render :json => artist

# pass id into related artist string
render :json => @related_artists
end
end
end
