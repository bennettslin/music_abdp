module AjaxFlash
  extend ActiveSupport::Concern

  included do
    after_filter :add_flash_to_header
  end

  private
  def add_flash_to_header
    # only run this in case it's an Ajax request.
    return unless request.xhr?
    # add flash to header
    response.headers['X-Flash'] = flash.to_h.to_json
    # make sure flash does not appear on the next page
    flash.discard
  end

end

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.


  protect_from_forgery with: :exception

  before_action :current_user

  # this populates the genre checkboxes in the user dashboard modal
  before_action :genres

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

end
