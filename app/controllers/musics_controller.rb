class MusicsController < ApplicationController
  attr_accessor :track_details
  attr_accessor :artist_details
  attr_accessor :artist_name
  attr_accessor :track_name
  attr_accessor :song_preview
  attr_accessor :music
  attr_accessor :not_found
  attr_accessor :beer_id
  def index
    puts "NOW HEEEERE"
    @music = Music.new
    render 'index'
  end

  def create
    artist = params[:music][:artist]
    track = params[:music][:track]
    if (flash[:error])
      @music = Music.new
      flash[:error] = nil
      render "index"
    elsif ((artist.length < 1) && (track.length < 1))
      @music = Music.new
      flash[:error] = "Both Fields Must Be Filled In!"
      render "index"
    elsif (artist.length < 1)
      @music = Music.new
      flash[:error] = "Artist Field Must Be Filled In!"
      render 'index'
    elsif (track.length < 1)
      @music = Music.new
      flash[:error] = "Track Field Must Be Filled In!"
      render 'index'
    else
      self.artist_name = artist
      self.track_name = track
      all_music_details = Music.set_params(artist, track)
      if all_music_details.length < 2
        self.not_found = all_music_details
      else
        self.track_details = all_music_details["track_info"]
        self.artist_details = all_music_details["artist_info"]
        self.artist_name = all_music_details["artist_info"]["name"]
        self.track_name = all_music_details["song_name"]
        self.song_preview = all_music_details["song_prev"]
        self.beer_id = all_music_details["beer_id"]
      end
      render 'show'
    end

  end

  def show
    @artist_name = self.artist_name
    @track_name = self.track
    @show_details = self.track_details
  end
end
