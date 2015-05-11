class TestController < ApplicationController

  def index
  end


  def quiz
  respond_to do |format|
    format.json
    format.html
  end


end