class MusicsController < ApplicationController
  attr_accessor :track_details
  def index
    render 'index'
  end

  def create
    artist = params[:music][:artist]
    track = params[:music][:track]
    self.track_details = Music.set_params(artist, track)
    debugger
    render 'show'
  end

  def show

  end
end
