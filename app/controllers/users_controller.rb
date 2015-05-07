
class UsersController < ApplicationController
  require 'open-uri'

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create

    @user = User.create(user_params)
    if @user.save
      flash[:success] = "User created. Please sign up!"
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

        friends_list = "https://graph.facebook.com/" + @user.provider_id + "/friends?access_token=" + @user.provider_hash;

      elsif @user.provider == 'google_oauth2'

        friends_list = "https://www.googleapis.com/plus/v1/people/" + @user.provider_id

      end
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

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password)
  end

end