
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.


  protect_from_forgery with: :exception

  before_action :current_user

  # this populates the genre checkboxes in the user dashboard modal
  before_action :genres

  # this will get overridden in show, update, or destroy
  # before_action :user

  def is_authenticated?
    unless current_user
      flash[:danger] = "You are not logged in."
      redirect_to login_path
    end
  end

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def genres
    @genres ||= Genre.all
  end

  # def user
  #   @user ||= User.new
  # end

end
