class PasswordsController < ApplicationController

  def new

  end

  def create
    user = User.find_by_email(params[:email])

    if user
      user.set_password_reset
      UserMailer.password_reset(user).deliver
    end

    flash[:success] = "Password reset was sent!"
    redirect_to login_path
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
      redirect_to login_path

  end

end