include SongsHelper

class SongsController < ApplicationController

  def validate_artists

    spotify_results = []

    genre_artists.each do |object|
      spotify_artist_objects = [];

      object[:artists].each do |artist_string|
        artist_objects = RSpotify::Artist.search(artist_string, limit: 1)

        spotify_artist_object = {}
        if artist_objects.any?

          spotify_artist_object[:artist_name] = artist_string
          top_tracks = artist_objects[0].top_tracks(:US)

          if top_tracks.any?
            spotify_top_tracks = []

            # get top three tracks, or however many in the array
            max = [top_tracks.count, 3].min
            (0...max).each do |i|
              spotify_top_tracks << top_tracks[i].name
            end

            spotify_artist_object[:top_tracks] = spotify_top_tracks
          else
            spotify_artist_object[:top_tracks] = "no top tracks!!!!!!!!!!!!!!!!!!!!"
          end

        else
          spotify_artist_object[:artist_name] = artist_string + " not found!!!!!!!!!!!!!!!!!!!!"
        end
        spotify_artist_objects << spotify_artist_object
      end
      spotify_results << {:genre => object[:genre], :artists => spotify_artist_objects}
    end

    render :json => spotify_results
  end

  def generate_results do

  end

end