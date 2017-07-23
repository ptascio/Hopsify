class BeersController < ApplicationController
  def index
    @id = params[:info][:beer_id]
    @beer = Beer.get_beer_by_style(params[:info][:beer_id])

    render 'index'
  end

  def create
    debugger
    @beer = Beer.get_beer_by_style(params[:beer_id])
    render "index"
  end
end
