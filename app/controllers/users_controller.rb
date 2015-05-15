include UsersHelper

class UsersController < ApplicationController
  require 'open-uri'
  require 'net/https'
  respond_to :html, :json

  def stats
    if @current_user

      # FIXME: this is not DRY!

      # create genre hashes
      genre_hashes = empty_genre_hashes

      # create friends hash if facebook user, otherwise just user
      friends_array = nil
      user_hashes = nil
      if @current_user.provider == 'facebook'

        # create friends hashes
        friends_array = facebook_friends_array @current_user
        friends_array << @current_user

        user_hashes = friends_array.map do |user|
          pic_url = facebook_user_pic_url user
          {
            pic_url: pic_url,
            user_id: user.id,
            genre_hashes: empty_genre_hashes
          }
        end
      else
        friends_array = [@current_user]
        user_hashes = [{
          user_id: @current_user.id,
          genre_hashes: empty_genre_hashes
        }]
      end

      # add quiz data (genre, user, id) to hashes
      Quiz.all.map do |quiz|

        # get genre from quiz song
        if quiz.song_id
          song = Song.find(quiz.song_id)
          if song
            genre = Genre.find(song.genre_id)
            if genre
              genre_hash = genre_hashes[genre.value]

              # get user_hash of quiz's user
              user = User.find(quiz.user_id)
              if friends_array.include? user
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
            end
          end
        end
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
              question_ratings[:pic_url] = facebook_user_pic_url user
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

  else
    redirect_to root_path
  end
end

def index
  if @current_user && @current_user.email == ENV['MY_FACEBOOK_EMAIL'] && @current_user.provider == 'facebook'
    @users = User.all
  else
    redirect_to root_path
    return
  end
end

  # used by modal
  def new
    @user = User.new
    render layout: false
  end

  def create
    @user = User.create(user_params)
    @user.genres << @genres
    if @user.save
      flash[:success] = "User created. Please log in!"
      redirect_to @user
    else
      flash[:danger] = "User was not created."
      redirect_to root_path
    end
  end

  def show
    @user = User.find(params[:id])

    if @user == current_user && @user.provider == "facebook"
      @friends_array = facebook_friends_array @user;
    end

  end

  # used by modal
  def edit
    @user = User.find(params[:id])
    render layout: false
  end

  def update

    @user = User.find(params[:id])
    @user.update(user_params)

    @user.genres.clear

    genres = params[:user][:genre_ids]
    genres.each do |g|
      @user.genres << Genre.find(g) unless g.blank?
    end

    # FIXME: if user has no genres, user is given all the genres for now
    # this should obviously be handled more gracefully
    if @user.genres.empty?
      @user.genres << @genres
      @user.save
    end

    flash[:success] = "Your preferences have been updated!"
    redirect_to @user
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :genre_ids)
  end

end