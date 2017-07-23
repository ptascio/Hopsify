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
   attr_accessor :artist_genre

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
    if song_info["tracks"]["items"].empty?
      @all_info.push({"error"=>"We couldn't find that song. Are you sure that the artist and track
        names are spelled correctly? *Keep in mind that not all artists and songs
        are available on the Spotify platform."})
        return @all_info
    else
      @track_id = song_info["tracks"]["items"][0]["id"]
      @artist_id = song_info["tracks"]["items"][0]["album"]["artists"][0]["id"]
      get_track_details
    end
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
    @artist_info = JSON.parse(artist_info.body)
    @all_info.push(@artist_info)
    analyze_artist_genre(@artist_info)
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

  def self.analyze_artist_genre(artist_info)
    genres = artist_info["genres"]
    id=""
      if (genres.empty?)
        id = "99"
      elsif (genres.include?("hip hop") || genres.include?("rap"))
        id = "100"
      elsif (genres.include?("alternative rock") || genres.include?("indie rock"))
        id ="93"
      elsif (genres.include?("blues-rock") || genres.include?("classic rock"))
        id = "94"
      elsif (genres.include?("edm") || genres.include?("electro house"))
        id = "167"
      elsif (genres.include?("experimental") || genres.include?("avant-garde") || genres.include?("free jazz"))
        id = "130"
      else
        num = rand(90..120)
        id = num.to_s
      end
    @all_info.push(id)
    return @all_info
  end

end
