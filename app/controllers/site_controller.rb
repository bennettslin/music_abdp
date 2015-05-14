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
    @genre_hashes = Genre.all.map do |genre|
      {
        genre_name: genre.name,
        total_scores_array: [0, 0, 0],
        total_quizzes: 0
      }
    end

    # create user hashes
    user_hashes = User.all.map do |user|
      genre_hashes = Genre.all.map do |genre|
        {
          genre_name: genre.name,
          total_scores_array: [0, 0, 0],
          total_quizzes: 0
        }
      end
      {
        user_id: user.id,
        genre_hashes: genre_hashes
      }
    end

    Quiz.all.map do |quiz|

      song = Song.find(quiz.song_id)
      genre = Genre.find(song.genre_id)
      genre_hash = @genre_hashes[genre.id - 1]

      user = User.find(quiz.user_id)

      user_hash = nil
      (0...user_hashes.count).each do |i|
        if user_hashes[i][:user_id] == user.id
          user_hash = user_hashes[i]
          break
        end
      end

      user_genre_hash = user_hash[:genre_hashes][genre.id - 1]

      quiz_score_array = score_array_from_binary_score quiz.result
      (0...quiz_score_array.count).each do |i|

        genre_hash[:total_scores_array][i] += quiz_score_array[i]
        user_genre_hash[:total_scores_array][i] += quiz_score_array[i]

      end

      genre_hash[:total_quizzes] += 1
      user_genre_hash[:total_quizzes] += 1

    end

    add_percentages_to_genre_hashes @genre_hashes

    user_hashes.each do |user_hash|
      add_percentages_to_genre_hashes user_hash[:genre_hashes]
      add_ratings_to_genre_hashes user_hash[:genre_hashes]
    end

    @highest_percentages = []
    (0...@genre_hashes.count).each do |i|
      @highest_percentages << [{user_id:0, percentage:0},{user_id:0, percentage:0},{user_id:0, percentage:0}]
    end

    (0...user_hashes.count).each do |i| # i is number of users
      user_hash = user_hashes[i]
      (0...@genre_hashes.count).each do |j| # j is number of genres
        user_genre_hash = user_hash[:genre_hashes][j]
        (0...user_genre_hash[:percentages_array].count).each do |k| # k is number of questions
          if user_genre_hash[:percentages_array][k] > @highest_percentages[j][k][:percentage]
            @highest_percentages[j][k][:user_id] = user_hash[:user_id]
            @highest_percentages[j][k][:percentage] = user_genre_hash[:percentages_array][k]
          end
        end
      end
    end

    @highest_percentages.each do |genre_percentages|
      genre_percentages.each do |question_percentage|
        user_id = question_percentage[:user_id]
        if user_id != 0
          user = User.find(user_id)
          question_percentage[:user_name] = user.first_name
        else
          question_percentage[:user_name] = "No leader"
        end
      end
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
          question_ratings[:user_name] = user.first_name
        else
          question_ratings[:user_name] = "No leader"
        end
      end
    end

    if @current_user
      user_hashes.each do |user_hash|
        if @current_user.id == user_hash[:user_id]
          @user_hash = user_hash

        end
      end
    end

  end

end