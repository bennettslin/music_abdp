class SessionsController < ApplicationController

  def new
    render layout: false
  end

  def create
    @user = User.authenticate(params[:email], params[:password])
    if @user
      session[:user_id] = @user.id
      flash[:success] = "Login successful."
      redirect_to team_path
    else
      flash[:danger] = "Invalid credentials."
      redirect_to team_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:info] = "User has logged out."
    redirect_to team_path
  end

end