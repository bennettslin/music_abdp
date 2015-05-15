module UsersHelper

  def facebook_friends_array facebook_user
    friends_array = []
    friends_list = "https://graph.facebook.com/" + facebook_user.provider_id + "/friends?access_token=" + facebook_user.provider_hash
    begin
      data_hash = JSON.parse(open(URI.encode(friends_list)).read)
      data_hash['data'].select do |friend_hash|
        friend = User.find_by_provider_id(friend_hash['id'])
        if friend
          friends_array << friend
        end
      end
    rescue => event
      puts "failure: #{event}"
    end
    friends_array
  end

  def facebook_user_pic_url facebook_user
    if facebook_user.provider == 'facebook'
      "https://graph.facebook.com/" + facebook_user.provider_id + "/picture"
    else
      nil
    end
  end

end