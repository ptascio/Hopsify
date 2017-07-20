class Music
   include ActiveModel::Model
   require 'rest-client'
   require 'base64'
   require 'uri'

   attr_accessor :artist
   attr_accessor :track
   attr_accessor :track_id
   attr_accessor :token
   attr_accessor :search_query

  def self.set_params(artist, track)
    @artist = artist
    @track = track
    get_new_access_token
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

    @token = JSON.parse(new_token.body)["access_token"]
    get_music_info
  end

  def self.get_music_info
    uri = URI.parse('https://api.spotify.com/v1/search?')
    params = URI.decode_www_form(uri.query)
    params << ['q', "track:#{@track} artist:#{@artist}"]
    params << ['type', 'track']
    params << ['limit', '1']
    uri.query = URI.encode_www_form(params)
    music_info = RestClient::Request.execute(
      method: :get,
      url: "#{uri}",
      headers: {
        Authorization: "Bearer #{@token}"
      }
    )
    music_info = JSON.parse(music_info.body)
    @track_id = music_info["tracks"]["items"][0]["id"]
    get_track_details
  end

  def self.get_track_details
    uri = URI.parse("https://api.spotify.com/v1/audio-features/#{@track_id}")
    track_info = RestClient::Request.execute(
      method: :get,
      url: "#{uri}",
      headers: {
        Authorization: "Bearer #{@token}"
      }
    )

    puts track_info.body
  end

end
