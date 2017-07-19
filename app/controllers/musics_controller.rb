class MusicsController < ApplicationController
  def index

    render 'index'
  end

  def create
    artist = params[:music][:artist]
    album = params[:music][:album]
    track = params[:music][:track]
    Music.set_params(artist, album, track)
  end

  def get_new_access_token
  end

  def hit_spotify
  end
end
