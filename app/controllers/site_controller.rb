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

    quizzes = Quiz.all
    # quiz knows song, user, result


    render :json => quizzes
    return

  end

end