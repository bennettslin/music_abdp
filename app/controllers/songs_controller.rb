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

    # get all songs
    song0 = get_random_song artist0, genre.id
    song1 = get_random_song artist1, genre.id
    song2 = get_random_song artist2, genre.id

    # fail gracefully if any song failed to retrieve
    # FIXME: eventually redirect to an error path
    if !song0 || !song1 || !song2
      redirect_to root_path
      return
    end

    # song0 info - correct answer
    @song0_cover = song0[:image_url]
    @song0_url = song0[:preview_url]
    @song0_artist = song0[:artist]
    @song0_album_name = song0[:album]
    @song0_track_name = song0[:title]

    # song1 info
    @song1_artist = song1[:artist]
    @song1_album_name = song1[:album]
    @song1_track_name = song1[:title]

    # song2 info
    @song2_artist = song2[:artist]
    @song2_album_name = song2[:album]
    @song2_track_name = song2[:title]

    # so that view says "composer" instead of "artist" for classical
    @classical = genre.name == "Classical"

    # store correct song in a class variable (!)
    # this is bad practise, don't do what I'm doing here, haha...
    @@quiz_song = song0
  end

  def persist_results

    # persist song, if not already present in database
    if @@quiz_song.present?
      song = Song.find_or_create_by(itunes_id: @@quiz_song[:itunes_id]) do |song|
        song.itunes_id = @@quiz_song[:itunes_id]
        song.image_url = @@quiz_song[:image_url]
        song.preview_url = @@quiz_song[:preview_url]
        song.artist = @@quiz_song[:artist]
        song.album = @@quiz_song[:album]
        song.title = @@quiz_song[:title]
        song.genre_id = @@quiz_song[:genre_id]
        song.buy_url = @@quiz_song[:buy_url]
        print song.buy_url
      end
    end

    # persist quiz
    if params["score"].present?
      # set user id to 0 if no current user
      user_id = @current_user ? @current_user.id : 0;
      quiz = Quiz.create(user_id:user_id, song_id: song.id, result: params["score"])
    end

    redirect_to root_path
  end

  # for development only
  def validate_artists

    itunes_results = []

    genre_artists.each do |object|
      itunes_artist_objects = [];

      object[:artists].each do |artist_string|

        request = Typhoeus::Request.new(
          "itunes.apple.com/search",
          method: :get,
          params: { term: artist_string, attribute: "allArtistTerm", entity: "song", limit: 5 }
          )

        response = request.run
        data = JSON.parse(response.body)
        track_objects = data["results"]

        itunes_artist_object = {}

        # there are some tracks
        if track_objects.any?

          itunes_top_tracks = track_objects.map do |track|
            track["trackName"]
          end
          itunes_artist_object[:top_tracks] = itunes_top_tracks

          # no tracks for this artist
        else
          itunes_artist_object[:top_tracks] = artist_string + " has no top tracks!!!!!!!!!!!!!!!!!!!!"
        end

        itunes_artist_objects << itunes_artist_object
      end
      itunes_results << {:genre => object[:genre], :artists => itunes_artist_objects}
    end

    render :json => itunes_results
  end

  def persist_new_random_quiz
    user_count = User.count
    user = User.offset(rand(0...user_count)).first
    genre_index = rand(0...genre_artists.count)
    artist_index = rand(0...genre_artists[genre_index][:artists].count)
    artist_string = genre_artists[genre_index][:artists][artist_index]

    request = Typhoeus::Request.new(
      "itunes.apple.com/search",
      method: :get,
      params: { term: artist_string, attribute: "allArtistTerm", entity: "song", limit: 5 }
      )
    response = request.run
    data = JSON.parse(response.body)
    song = data["results"]
    song_random = song[rand(0...song.count)]

    itunes_id = song_random['trackId']
    song_cover_long = song_random['artworkUrl100']
    image_url = song_cover_long[0...-14] + "jpg"
    preview_url = song_random['previewUrl']
    artist_name = song_random['artistName']
    album_name = song_random['collectionName']
    track_name = song_random['trackName']
    buy_url = song_random['trackViewUrl']

    song = Song.find_or_create_by(itunes_id: itunes_id) do |song|
      song.image_url = image_url
      song.preview_url = preview_url
      song.artist = artist_name
      song.album = album_name
      song.title = track_name
      song.buy_url = buy_url
      song.genre_id = genre_index + 1 # will break if genre_ids are not 0 through 9
    end

    result = rand(0...8)
    quiz = Quiz.create(user_id:user.id, song_id: song.id, result: result)
    redirect_to root_path

  end

  def listen_later

    user = @current_user
    song = Song.find_by(itunes_id: @@quiz_song[:itunes_id])

    puts song

    user.songs << song

    redirect_to quiz_path

  end

  def remove_favorite



    song = Song.find(params[:id])

    result = @current_user.songs.delete(song)

    render :json => {result:result}


  end

  private

  def song_params
    params.require(:song).permit(:itunes_id, :image_url, :preview_url, :artist, :album, :title, :buy_url)
  end

end