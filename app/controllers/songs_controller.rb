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

    if @current_user

      if @current_user.quiz_song_id
        song = Song.find(@current_user.quiz_song_id)
        if song

          # if no other user has favourited song, delete it from database
          found_song = SongsUsers.find_by(song_id: song.id)
          if !found_song
            song.destroy
          end
        end
      end

      # store correct song as quiz song for user in database, for now
      quiz_song = Song.find_or_create_by(itunes_id: song0[:itunes_id]) do |song|
        song.itunes_id = song0[:itunes_id]
        song.image_url = song0[:image_url]
        song.preview_url = song0[:preview_url]
        song.artist = song0[:artist]
        song.album = song0[:album]
        song.title = song0[:title]
        song.genre_id = song0[:genre_id]
        song.buy_url = song0[:buy_url]
      end

      @current_user.quiz_song_id = quiz_song.id
      @current_user.save
    end

  end

  def persist_results

    # persist quiz
    if params["score"].present?
      # set user id to 0 if no current user
      user_id = @current_user ? @current_user.id : 0;
      quiz = Quiz.create(user_id:user_id, song_id: song.id, result: params["score"])
    end

    render :json => resource
    return

    redirect_to root_path
  end

  def listen_later

    # move quiz song to user's favourites
    if @current_user
      song = Song.find(@current_user.quiz_song_id)
      @current_user.songs << song
      @current_user.quiz_song_id = nil
      redirect_to quiz_path
    end
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