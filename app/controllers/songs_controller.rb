class SongsController < ApplicationController

  def random_artists

    # get list of artists by specified genre
    artists = RSpotify::Artist.search('genre:Pop')

    # gets three unique index numbers
    random_indices = Set.new
    while random_indices.count < 3 do
      random_indices << rand(artists.count)
    end

    # get three random artists based on index numbers
    random_artists = random_indices.map do |index|
      artists[index].name
    end

    # FIXME: temporarily show three random artists
    render :json => random_artists
    return

  end

end
