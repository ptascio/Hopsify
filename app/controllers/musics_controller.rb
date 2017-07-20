class MusicsController < ApplicationController
  def index

    render 'index'
  end

  def create
    artist = params[:music][:artist]
    track = params[:music][:track]
    Music.set_params(artist, track)
  end

  def get_new_access_token
  end

  def hit_spotify
  end
end
