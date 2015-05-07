
class UsersController < ApplicationController
  require 'open-uri'
  require 'net/https'
  require 'google/api_client'
  require 'google/api_client/client_secrets'

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create

    @user = User.create(user_params)
    if @user.save
      flash[:success] = "User created. Please sign up!"
      redirect_to login_path
    else
      flash[:danger] = "User was not created."
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    @friends_array = [];
    friends_list = ""

    if @user == current_user

      if @user.provider == "facebook"
        friends_list = "https://graph.facebook.com/" + @user.provider_id + "/friends?access_token=" + @user.provider_hash

      elsif @user.provider == 'google_oauth2'
        # friends_list = "https://www.googleapis.com/plus/v1/people/" + @user.provider_id + "/people/connected"

        # $authorization = Signet::OAuth2::Client.new(
        #   :authorization_uri => "https://accounts.google.com/o/oauth2/auth",
        #   :token_credential_uri => "https://accounts.google.com/o/oauth2/token",
        #   :client_id => ENV['GOOGLE_CLIENT_ID'],
        #   :client_secret => ENV['GOOGLE_CLIENT_SECRET'],
        #   :redirect_uri => "postmessage",
        #   :scope => 'https://www.googleapis.com/auth/plus.login')

        # # Upgrade the code into a token object.
        # $authorization.code = request.body.read
        # $authorization.fetch_access_token!
        # $client.authorization = $authorization

        # id_token = $client.authorization.id_token
        # encoded_json_body = id_token.split('.')[1]
        # # Base64 must be a multiple of 4 characters long, trailing with '='
        # encoded_json_body += (['='] * (encoded_json_body.length % 4)).join('')
        # json_body = Base64.decode64(encoded_json_body)
        # body = JSON.parse(json_body)
        # # You can read the Google user ID in the ID token.
        # # "sub" represents the ID token subscriber which in our case
        # # is the user ID. This sample does not use the user ID.
        # gplus_id = body['sub']

        # $client = Google::APIClient.new
        # $client.authorization = $authorization

        # Serialize and store the token in the user's session.
        # token_pair = TokenPair.new
        # token_pair.update_token!($client.authorization)
        # session_token = token_pair
        # session_hash = session_token.to_hash
        # session_hash[:access_token] = @user.provider_hash

        # # Authorize the client and construct a Google+ service.
        # $client.authorization.update_token!(session_hash)
        # plus = $client.discovered_api('plus', 'v1')

        # # Get the list of people as JSON and return it.
        # response = $client.execute!(plus.people.list,
        #     :collection => 'connected',
        #     :userId => 'me').body
        # content_type :json
        # render :json => response
        # return


      elsif @user.provider == "linkedin"


      elsif @user.provider == "twitter"


      end

      begin
        data_hash = JSON.parse(open(URI.encode(friends_list)).read)
        data_hash['data'].select do |friend_hash|
          friend = User.find_by_provider_id(friend_hash['id'])
          if friend
            @friends_array << friend
          end
        end
      rescue => event
        puts "failure: #{event}"
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password)
  end

end

# class TokenPair
#   @refresh_token
#   @access_token
#   @expires_in
#   @issued_at

#   def update_token!(object)
#     @refresh_token = object.refresh_token
#     @access_token = object.access_token
#     @expires_in = object.expires_in
#     @issued_at = object.issued_at
#   end

#   def to_hash
#     return {
#       :refresh_token => @refresh_token,
#       :access_token => @access_token,
#       :expires_in => @expires_in,
#       :issued_at => Time.new
#     }
#   end
# end