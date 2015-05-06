class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.authenticate(params[:user][:email], params[:user][:password])
    if @user
      session[:user_id] = @user.id
      flash[:success] = "Login successful."
      redirect_to @user
    else
      flash[:danger] = "Invalid credentials."
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:info] = "User has logged out."
    redirect_to login_path
  end

end