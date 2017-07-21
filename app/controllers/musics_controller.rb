class MusicsController < ApplicationController
  attr_accessor :track_details
  attr_accessor :artist_details
  attr_accessor :artist_name
  attr_accessor :track_name
  attr_accessor :music
  def index
    @music = Music.new
    render 'index'
  end

  def create
    artist = params[:music][:artist]
    track = params[:music][:track]

    if ((artist.length < 1) && (track.length < 1))
      @music = Music.new
      flash[:error] = "Both Fields Must Be Filled In!"
      render 'index'
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
      self.track_details = all_music_details[0]
      self.artist_details = all_music_details[1]
      render 'show'
    end

  end

  def show
    @artist_name = self.artist_name
    @track_name = self.track
    @show_details = self.track_details
  end
end
