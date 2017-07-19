class Music
   include ActiveModel::Model
   require 'rest-client'
   require 'base64'

   attr_accessor :artist
   attr_accessor :album
   attr_accessor :track
   attr_accessor :search_query

  def self.set_params(artist, album, track)
    @artist = URI::encode(artist)
    @album = URI::encode(album)
    @track = URI::encode(track)
  end

  def self.make_search_query
    @search_query = @artist + " " + @album + " " + @track

  end

  def self.get_new_access_token
    new_token = RestClient::Request.execute(
      method: :post,
      url: 'https://accounts.spotify.com/api/token',
      payload: {'grant_type': 'client_credentials'},
      headers: {
        Authorization: ENV["hashed_auth"]
      }
    )

    token = JSON.parse(new_token.body)["access_token"]
    get_music_info(token)
  end

  def self.get_music_info(token)
    music_info = RestClient::Request.execute(
      method: :get,
      url: 'https://api.spotify.com/v1/search?q=tania%20bowra&type=artist',
      headers: {
        Authorization: "Bearer #{token}"
      }
    )

    puts music_info.body
  end

end
