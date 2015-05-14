include SiteHelper

class SiteController < ApplicationController

  def about
    render layout: false
  end

  def team

  end

  def favorite

    user = @current_user.id

    # gets current user's fav song IDs
    favorite_entries = SongsUsers.where(user_id: user)
    favs_ids = favorite_entries.map do |x|
      x['song_id']
    end

    # gets user's favorites details
    @favs_info = favs_ids.map do |x|
      Song.find_by_id(x)
    end

    render layout: false
    # render :json => @favs_info_itunes_ids

  end

  def leaderboard

    # create genre hashes
    @genre_hashes = Genre.all.map do |genre|
      {
        genre_name: genre.name,
        total_scores_array: [0, 0, 0],
        total_quizzes: 0
      }
    end

    # create user hashes
    user_hashes = User.all.map do |user|
    end

    Quiz.all.map do |quiz|

      song = Song.find(quiz.song_id)
      genre = Genre.find(song.genre_id)
      genre_hash = @genre_hashes[genre.id - 1]

      quiz_score_array = score_array_from_binary_score quiz.result

      (0... quiz_score_array.count).each do |i|
        genre_hash[:total_scores_array][i] += quiz_score_array[i]
      end

      genre_hash[:total_quizzes] += 1
    end

  end

end