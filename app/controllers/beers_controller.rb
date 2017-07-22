class BeersController < ApplicationController
  def index
    @beer = Beer.get_beer_info
    render 'index'
  end

  def create

    render "show"
  end
end
