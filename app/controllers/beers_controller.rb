class BeersController < ApplicationController
  def index
    @beer = Beer.get_beer_by_style(params[:info][:beer_id])

    render 'index'
  end

  def create

    render "show"
  end
end
