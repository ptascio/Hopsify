class BeersController < ApplicationController


  def index
    @id = params[:info][:beer_id]
    if @id == "6969"
      @beer = Beer.get_bud_light
    else
      @beer = Beer.get_beer_by_style(params[:info][:beer_id])
    end
    render 'index'
  end

  def create
    if params[:beer_id] == "6969"
      @beer = Beer.get_bud_light
    else
      @beer = Beer.get_beer_by_style(params[:beer_id])
    end
    render "index"
  end
end
