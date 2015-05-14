include SiteHelper

class SiteController < ApplicationController

  def about
    render layout: false
  end

  def team

  end

  def favorite
    render layout: false
  end

  def leaderboard

    # create genre hashes
    @genre_hashes = empty_genre_hashes

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
      genre_hash = @genre_hashes[genre.id - 1]

      # get user_hash of quiz's user
      user = User.find(quiz.user_id)
      user_hash = user_hash_from_user_hashes user_hashes, user
      user_genre_hash = user_hash[:genre_hashes][genre.id - 1]

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
    add_percentages_to_genre_hashes @genre_hashes

    # remember ratings for each user
    user_hashes.each do |user_hash|
      add_ratings_to_genre_hashes user_hash[:genre_hashes]
    end

    @highest_ratings = []
    (0...@genre_hashes.count).each do |i|
      @highest_ratings << [{user_id:0, rating:0},{user_id:0, rating:0},{user_id:0, rating:0}]
    end

    (0...user_hashes.count).each do |i| # i is number of users
      user_hash = user_hashes[i]
      (0...@genre_hashes.count).each do |j| # j is number of genres
        user_genre_hash = user_hash[:genre_hashes][j]
        (0...user_genre_hash[:ratings_array].count).each do |k| # k is number of questions
          if user_genre_hash[:ratings_array][k] > @highest_ratings[j][k][:rating]
            @highest_ratings[j][k][:user_id] = user_hash[:user_id]
            @highest_ratings[j][k][:rating] = user_genre_hash[:ratings_array][k]
          end
        end
      end
    end

    @highest_ratings.each do |genre_ratings|
      genre_ratings.each do |question_ratings|
        user_id = question_ratings[:user_id]
        if user_id != 0
          user = User.find(user_id)
          question_ratings[:user_name] = user.first_name + " " + user.last_name[0, 1] + "."
        else
          question_ratings[:user_name] = "No leader"
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

  end

end