class BeersController < ApplicationController
  def index
    @id = params[:info][:beer_id]
    @beer = Beer.get_beer_by_style(params[:info][:beer_id])

    render 'index'
  end

  def create

    render "show"
  end
end
