class QuizzesController < ApplicationController
end

def quiz
  respond_to do |format|
    format.json
    format.html
end
