class BeersController < ApplicationController


  def index
    debugger
    if params[:info].nil?
      redirect_to root_path
    else
      @id = params[:info][:beer_id]
      @artist_pic = params["info"]["artist_details"]["images"][1]["url"]
      @artist_name = params["info"]["artist_details"]["name"]
      if @id == "6969"
        @beer = Beer.get_bud_light
      else
        @beer = Beer.get_beer_by_style(params[:info][:beer_id])
      end
      render 'index'
    end

  end

  def create
    debugger
    if params[:beer_id] == "6969"
      @beer = Beer.get_bud_light
    else
      @artist_pic = params[:artist_pic]
      @artist_name = params[:artist_name]
      @id = params[:beer_id]
      @beer = Beer.get_beer_by_style(params[:beer_id])
    end
    render "index"
  end
end
