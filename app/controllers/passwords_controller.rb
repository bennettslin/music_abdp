class PasswordsController < ApplicationController

  def login_reset
    if @current_user
      @current_user.set_password_reset
      redirect_to '/passwords/' + @current_user.code + '/edit'
    else
      redirect_to root_path
    end
  end

  def new

  end

  def create
    user = User.find_by_email(params[:email])

    if user && !user.provider
      user.set_password_reset
      UserMailer.password_reset(user).deliver
      flash[:success] = "Password reset was sent!"
    elsif user && user.provider
      flash[:danger] = "The user with that email signed in through a third party."
    else
      flash[:danger] = "No user with that email was found."
    end

    redirect_to root_path
  end

  def edit
    @user = User.find_by_code(params[:id])
  end

  def update
    user = User.find_by_code(params[:id])

    if user && Time.now < user.expires_at
      user.password = params[:user][:password]
      user.code = nil
      user.expires_at = nil
      user.save
      flash[:success] = "Password was successfully reset!"
    else

    end
      redirect_to root_path

  end

end