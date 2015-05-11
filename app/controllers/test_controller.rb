class TestController < ApplicationController

  def index

    # Randomly chooses genre from user preferences
    if @current_user
      genres_max = @current_user.genres.count - 1
      genre = @current_user.genres[rand(0..genres_max)]
    else
      genre = Genre.all[rand(0..(genres.count - 1))]
    end

    # render :json => genre.name


    # Get list of artists by specified genre
    artists = RSpotify::Artist.search('genre:' + genre.name)

    # Gets three unique index numbers
    random_indices = Set.new
    while random_indices.count < 3 do
      random_indices << rand(artists.count)
    end

    # Gets three random artists based on index numbers
    random_artists = random_indices.map do |index|
      artists[index].name
    end

    # Separates the three random artist names
    artist0 = random_artists[0]
    artist1 = random_artists[1]
    artist2 = random_artists[2]

    # song0 info
    song0 = RSpotify::Track.search('artist:' + artist0, limit: 50)
    song0_random = song0[rand(0..40)]
    @song0_cover = song0_random.album.images[0]['url']
    @song0_url = song0_random.preview_url
    @song0_artist = artist0
    @song0_track_name = song0_random.name
    @song0_album_name = song0_random.album.name

    # song1 info
    song1 = RSpotify::Track.search('artist:' + artist1, limit: 50)
    song1_random = song1[rand(0..40)]
    @song1_artist = artist1
    @song1_track_name = song1_random.name
    @song1_album_name = song1_random.album.name

    # song2 info
    song2 = RSpotify::Track.search('artist:' + artist2, limit: 50)
    song2_random = song2[rand(0..40)]
    @song2_artist = artist2
    @song2_track_name = song2_random.name
    @song2_album_name = song2_random.album.name

    # render :json => @song2_album_name

  end

  def quiz
    respond_to do |format|
      format.json
      format.html
    end
  end

end