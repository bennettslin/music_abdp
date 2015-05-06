class AuthController < ApplicationController

  def callback
    provider_user = request.env['omniauth.auth']

    # FIXME: for situation where same user logs in with different accounts
    # at different times (for example Facebook then Google)
    # I turned off validation of unique email to get around this for now,
    # but obviously this is not an ideal solution

    if params[:provider] == "facebook"
      # render json: provider_user
      # return

      # find or create a user
      user = User.find_or_create_by(provider_id:provider_user['uid'], provider: params[:provider]) do |u|
        u.provider_hash = provider_user['credentials']['token']
        u.first_name = provider_user['info']['first_name']
        u.email = provider_user['info']['email']
        u.password = "123"
      end

      # create user session
      session[:user_id] = user.id

    elsif params[:provider] == "google_oauth2"
      user = User.find_or_create_by(provider_id:provider_user['uid'], provider: params[:provider]) do |u|
        u.provider_hash = provider_user['credentials']['token']
        u.first_name = provider_user['info']['first_name']
        u.email = provider_user['info']['email']
        u.password = "123"
      end

      # create user session
      session[:user_id] = user.id

    elsif params[:provider] == "twitter"
      user = User.find_or_create_by(provider_id:provider_user['uid'], provider: params[:provider]) do |u|
        u.provider_hash = provider_user['credentials']['token']
        u.first_name = provider_user['info']['first_name']
        u.email = "#{provider_user['info']['nickname']}@example.com"
        u.password = "123"
      end

      # create user session
      session[:user_id] = user.id

    elsif params[:provider] == "linkedin"
      user = User.find_or_create_by(provider_id:provider_user['uid'], provider: params[:provider]) do |u|
        u.provider_hash = provider_user['credentials']['token']
        u.first_name = provider_user['info']['first_name']
        u.email = provider_user['info']['email']
        u.password = "123"
      end

      # create user session
      session[:user_id] = user.id

    end

    # send them home
    redirect_to root_path
  end

  def logout
    # end user session
    session[:user_id] = nil
    redirect_to root_path
  end

  def failure
    # TODO: display error page
    render plain: "This is a failure."
  end

end