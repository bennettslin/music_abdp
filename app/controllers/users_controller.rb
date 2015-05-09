
class UsersController < ApplicationController
  require 'open-uri'
  require 'net/https'

  def index
    if @current_user && @current_user.email == ENV['MY_FACEBOOK_EMAIL'] && @current_user.provider == 'facebook'
    @users = User.all
    else
      redirect_to login_path
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
      redirect_to team_path
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