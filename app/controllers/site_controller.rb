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
    genre_hashes = empty_genre_hashes

    # create user hashes
    user_hashes = User.all.map do |user|
      {
        user_id: user.id,
        genre_hashes: empty_genre_hashes
      }
    end

    # add quiz data (genre, user, id) to hashes
    Quiz.all.map do |quiz|

      # get genre from quiz song
      song = Song.find(quiz.song_id)
      genre = Genre.find(song.genre_id)
      genre_hash = genre_hashes[genre.value]

      # get user_hash of quiz's user
      user = User.find(quiz.user_id)
      user_hash = user_hash_from_user_hashes user_hashes, user
      user_genre_hash = user_hash[:genre_hashes][genre.value]

      # get true scores for each question from binary score
      quiz_score_array = score_array_from_binary_score quiz.result

      # add true scores to genre and user hashes
      (0...quiz_score_array.count).each do |i|
        genre_hash[:total_scores_array][i] += quiz_score_array[i]
        user_genre_hash[:total_scores_array][i] += quiz_score_array[i]
      end

      # add quiz to total
      genre_hash[:total_quizzes] += 1
      user_genre_hash[:total_quizzes] += 1
    end

    # remember percentage for each genre
    add_percentages_to_genre_hashes genre_hashes

    # remember ratings for each user
    user_hashes.each do |user_hash|
      add_ratings_to_genre_hashes user_hash[:genre_hashes]
    end

    all_highest_ratings = []
    (0...genre_hashes.count).each do |i| # i is number of genres
      genre_highest_ratings = []

      (0...3).each do |j| # j is number of questions
        question_highest_ratings = []

        (0...5).each do |k| # k is number of leaders
          question_highest_ratings << {user_id:0, rating:0}
        end
        genre_highest_ratings << question_highest_ratings
      end
      all_highest_ratings << genre_highest_ratings
    end

    (0...user_hashes.count).each do |i| # i is number of users
      user_hash = user_hashes[i]
      (0...genre_hashes.count).each do |j| # j is number of genres
        user_genre_hash = user_hash[:genre_hashes][j]
        (0...user_genre_hash[:ratings_array].count).each do |k| # k is number of questions

          compared_id = user_hash[:user_id]
          compared_rating = user_genre_hash[:ratings_array][k]

          (0...5).each do |l| # l is number of leaders
            if compared_rating > all_highest_ratings[j][k][l][:rating]

              next_compared_id = all_highest_ratings[j][k][l][:user_id]
              next_compared_rating = all_highest_ratings[j][k][l][:rating]

              all_highest_ratings[j][k][l][:user_id] = compared_id
              all_highest_ratings[j][k][l][:rating] = compared_rating

              compared_id = next_compared_id
              compared_rating = next_compared_rating
            end
          end
        end
      end
    end

    all_highest_ratings.each do |highest_ratings|
      highest_ratings.each do |genre_ratings|
        genre_ratings.each do |question_ratings|
          user_id = question_ratings[:user_id]
          if user_id != 0
            user = User.find(user_id)
            question_ratings[:user_name] = user.first_name + " " + user.last_name[0, 1] + "."
            question_ratings[:user] = user
          else
            question_ratings[:user_name] = "No leader"
          end
        end
      end
    end

    # if current user, include data for current user in view
    if @current_user
      user_hashes.each do |user_hash|
        if @current_user.id == user_hash[:user_id]
          @user_hash = user_hash
        end
      end
    end

    @genre_hashes = genre_hashes
    @all_highest_ratings = all_highest_ratings

  end

end