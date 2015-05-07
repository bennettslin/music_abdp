require 'open-uri'

class UsersController < ApplicationController

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

    if (@user.provider == "facebook")

      friends_list = "https://graph.facebook.com/#{@user.provider_id}/friends?access_token=#{@user.provider_hash}";
      render :json => friends_list
      return
      open friends_list do |io|
        data = io.read
        render :json => data
        return
      end

    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password)
  end

end