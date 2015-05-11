class SongsController < ApplicationController
  require 'rspotify'

  def artist
    artist = RSpotify::Artist.search('One Direction')
    #search term variable

    artist.each do |x|
      @id=x.id
    #   return @related_artists unless @related_artists.nil?
    #   # json = RSpotify.get("artists/7Ln80lUS6He07XvHI8qqHH/related-artists")
    #   json = RSpotify.get("artists/#{@id}/related-artists")
    #   @related_artists = json['artists'][0,2]

# render :json => artist

# pass id into related artist string
# render :json => @related_artists


   def top_tracks(pop)
      return @top_tracks[pop] unless @top_tracks[pop].nil?
      json = RSpotify.get("artists/#{@id}/top-tracks?pop=#{pop}")
      @top_tracks[pop] = json['tracks']

      render :json => @top_tracks
    end
end
end

end