class Music
   include ActiveModel::Model
   require 'rest-client'
   require 'base64'

   attr_accessor :artist
   attr_accessor :album
   attr_accessor :track

  def self.get_new_access_token
    new_token = RestClient::Request.execute(
      method: :post,
      url: 'https://accounts.spotify.com/api/token',
      payload: {'grant_type': 'client_credentials'},
      headers: {
        Authorization: ENV["hashed_auth"]
      }
    )
    puts new_token.body


  end

end
