class Music
   include ActiveModel::Model
   require 'rest-client'
   require 'base64'
   require 'uri'

   attr_accessor :artist
   attr_accessor :track
   attr_accessor :track_id
   attr_accessor :token
   attr_accessor :artist_info
   attr_accessor :artist_id
   attr_accessor :all_info

  def self.set_params(artist, track)
    @artist = artist
    @track = track
    @all_info = []
    get_new_access_token
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
    get_song_info
  end

  def self.get_song_info
    uri = URI.parse('https://api.spotify.com/v1/search?')
    params = URI.decode_www_form(uri.query)
    params << ['q', "track:#{@track} artist:#{@artist}"]
    params << ['type', 'track']
    params << ['limit', '1']
    uri.query = URI.encode_www_form(params)
    song_info = RestClient::Request.execute(
      method: :get,
      url: "#{uri}",
      headers: {
        Authorization: "Bearer #{@token}"
      }
    )
    song_info = JSON.parse(song_info.body)
    @track_id = song_info["tracks"]["items"][0]["id"]
    @artist_id = song_info["tracks"]["items"][0]["album"]["artists"][0]["id"]
    get_track_details
  end

  def self.get_artist_details
    uri = URI.parse("https://api.spotify.com/v1/artists/#{@artist_id}")
    artist_info = RestClient::Request.execute(
      method: :get,
      url: "#{uri}",
      headers: {
        Authorization: "Bearer #{@token}"
      }
    )

    @all_info.push(JSON.parse(artist_info.body))
    return @all_info
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

    @all_info.push(JSON.parse(track_info.body))
    get_artist_details
  end

end
