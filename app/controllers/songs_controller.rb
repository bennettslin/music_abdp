require 'typhoeus'
include SongsHelper

class SongsController < ApplicationController

  def quiz

    # Randomly chooses genre from user preferences
    if @current_user
      genres_max = @current_user.genres.count - 1
      genre = @current_user.genres[rand(0..genres_max)]
    else
      genre = Genre.all[rand(0...genres.count)]
    end

    # Get list of artists by specified genre
    artists = genre_artists[genre.value][:artists]

    # Gets three unique index numbers
    random_indices = Set.new
    while random_indices.count < 3 do
      random_indices << rand(artists.count)
    end

    # Gets three random artists based on index numbers
    random_artists = random_indices.map do |index|
      artists[index]
    end

    # Separates the three random artist names
    artist0 = random_artists[0]
    artist1 = random_artists[1]
    artist2 = random_artists[2]

    # song0 info - correct answer
    request = Typhoeus::Request.new(
      "itunes.apple.com/search",
      method: :get,
      params: { term: artist0, attribute: "allArtistTerm", entity: "song", limit: 50 }
      )
    response = request.run
    data = JSON.parse(response.body)
    song0 = data["results"]
    song0_random = song0[rand(0...song0.count)]
    song0_cover_long = song0_random['artworkUrl100']
    @song0_cover = song0_cover_long[0...-14] + "jpg"
    @song0_url = song0_random['previewUrl']
    @song0_artist = song0_random['artistName']
    @song0_track_name = song0_random['trackName']
    @song0_album_name = song0_random['collectionName']

    # store correct song in a class variable (!)
    @@quiz_song = {
      itunes_id: song0_random['trackId'],
      image_url: @song0_cover,
      preview_url: @song0_url,
      artist: @song0_artist,
      album: @song0_album_name,
      title: @song0_track_name,
      genre_id: genre.id
    }

    # song1 info
    request = Typhoeus::Request.new(
      "itunes.apple.com/search",
      method: :get,
      params: { term: artist1, attribute: "allArtistTerm", entity: "song", limit: 50 }
      )
    response = request.run
    data = JSON.parse(response.body)
    song1 = data["results"]
    song1_random = song1[rand(0...song1.count)]
    @song1_artist = song1_random['artistName']
    @song1_track_name = song1_random['trackName']
    @song1_album_name = song1_random['collectionName']

    # song2 info
    request = Typhoeus::Request.new(
      "itunes.apple.com/search",
      method: :get,
      params: { term: artist2, attribute: "allArtistTerm", entity: "song", limit: 50 }
      )
    response = request.run
    data = JSON.parse(response.body)
    song2 = data["results"]
    song2_random = song2[rand(0...song2.count)]
    @song2_artist = song2_random['artistName']
    @song2_track_name = song2_random['trackName']
    @song2_album_name = song2_random['collectionName']
    # render :json => @song2_album_name
  end

  def persist_results

    # persist song, if not already present in database
    if @@quiz_song.present?
      song = Song.find_or_create_by(spotify_id: @@quiz_song[:spotify_id]) do |song|
        song.spotify_id = @@quiz_song[:spotify_id]
        song.image_url = @@quiz_song[:image_url]
        song.preview_url = @@quiz_song[:preview_url]
        song.artist = @@quiz_song[:artist]
        song.album = @@quiz_song[:album]
        song.title = @@quiz_song[:title]
        song.genre_id = @@quiz_song[:genre_id]
      end
    end

    # persist quiz
    if params["score"].present?
      user_id = @current_user ? @current_user.id : 0;
      quiz = Quiz.create(user_id:user_id, song_id: song.id, result: params["score"])
    end

    redirect_to root_path
  end

  # for development only
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

  private

  def song_params
    params.require(:song).permit(:spotify_id, :image_url, :preview_url, :artist, :album, :title)
  end

end