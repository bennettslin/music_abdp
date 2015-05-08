
class UsersController < ApplicationController
  require 'open-uri'
  require 'net/https'

  def index
    @users = User.all
  end

  def new
    @user = User.new
    @signup = true
  end

  def create

    @user = User.create(user_params)
    @user.genres << @genres
    if @user.save
      flash[:success] = "User created. Please log in!"
      redirect_to login_path
    else
      flash[:danger] = "User was not created."
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    @friends_array = [];
    friends_list = ""

    if @user == current_user

      if @user.provider == "facebook"
        friends_list = "https://graph.facebook.com/" + @user.provider_id + "/friends?access_token=" + @user.provider_hash

      elsif @user.provider == 'google_oauth2'

      elsif @user.provider == "linkedin"

      elsif @user.provider == "twitter"

      end

      begin
        data_hash = JSON.parse(open(URI.encode(friends_list)).read)
        data_hash['data'].select do |friend_hash|
          friend = User.find_by_provider_id(friend_hash['id'])
          if friend
            @friends_array << friend
          end
        end
      rescue => event
        puts "failure: #{event}"
      end
    end
  end

  def update

    @user = User.find(params[:id])
    @user.update(user_params)

    @user.genres.clear

    genres = params[:user][:genre_ids]
    genres.each do |g|
      @user.genres << Genre.find(g) unless g.blank?

    end
    flash[:success] = "Your preferences have been updated!"
    redirect_to @user
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :genre_ids)
  end

end