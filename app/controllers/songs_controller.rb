include SongsHelper

class SongsController < ApplicationController
<<<<<<< HEAD
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

=======

  def random_artists

    # Randomly chooses genre from user preferences
    genres_max = @current_user.genres.count - 1
    genre = @current_user.genres[rand(0..genres_max)]

    # render :json => genre.name


    # Get list of artists by specified genre
    artists = RSpotify::Artist.search('genre:' + "Pop")
    # artists = RSpotify::Artist.search('genre:' + genre.name)
    ## Fix so that errors don't occur on some genres

    # Gets three unique index numbers
    random_indices = Set.new
    while random_indices.count < 3 do
      random_indices << rand(artists.count)
    end

    # Gets three random artists based on index numbers
    random_artists = random_indices.map do |index|
      artists[index].name
    end

    render :json => random_artists

    # Separates the three random artist names
    artist0 = random_artists[0]
    artist1 = random_artists[1]
    artist2 = random_artists[2]

    # artist0 song preview w/ album art
    song0 = RSpotify::Track.search('artist:' + artist0, limit: 50)
    song0_random = song0[rand(0..40)]
    @song0_cover = song0_random.album.images[0]['url']
    @song0_url = song0_random.preview_url


    # render :json => song0_random.name

  end

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
>>>>>>> 20db5aa2da1167faeaa2e065ec9e5b499467d578
end