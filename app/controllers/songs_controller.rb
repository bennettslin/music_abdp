class SongsController < ApplicationController

  include SongsHelper

  # method to find all artists within a genre
  # offset did not work; just returns the same twenty artists

  # def all_artists

  #   # get list of artists by specified genre
  #   all_artists = []
  #   (1..1).each do |i|
  #     all_genre_artists = []

  #     counter = 0
  #     loop do
  #       artists = RSpotify::Artist.search("genre:" + Genre.find(i).name + ",offset:" + (counter * 20).to_s)

  #       if artists.any?
  #         (0...artists.count).each do |i|
  #           all_genre_artists << artists[i].name
  #           puts artists[i].name
  #         end
  #         counter += 1
  #       else
  #         break
  #       end
  #     end

  #     genre_artist_count_string = all_genre_artists.count.to_s + " " + Genre.find(i).name
  #     puts genre_artist_count_string
  #     all_genre_artists << genre_artist_count_string
  #     all_artists << all_genre_artists
  #   end

  #   # FIXME: temporarily show three random artists
  #   render :json => all_artists
  #   return

  # end

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
end