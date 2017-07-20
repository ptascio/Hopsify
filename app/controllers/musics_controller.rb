class MusicsController < ApplicationController
  attr_accessor :track_details
  attr_accessor :artist_details
  attr_accessor :artist_name
  attr_accessor :track_name
  def index
    render 'index'
  end

  def create
    artist = params[:music][:artist]
    track = params[:music][:track]
    self.artist_name = artist
    self.track_name = track
    all_music_details = Music.set_params(artist, track)
    self.track_details = all_music_details[0]
    self.artist_details = all_music_details[1]
    debugger
    render 'show'
  end

  def show
    @artist_name = self.artist_name
    @track_name = self.track
    @show_details = self.track_details
  end
end
