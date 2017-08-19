class BeersController < ApplicationController
  attr_accessor :beer
  attr_accessor :search_count

  def index
    if params[:info].nil?
      redirect_to root_path
    else
      @id = params[:info][:beer_id]
      image = nil
      if (params["info"]["artist_details"]["images"])
        image = params["info"]["artist_details"]["images"][1]["url"]
      else
        image = "cowbell.jpeg"
      end
      @song_title = params["info"]["track_name"]
      @artist_pic =  image
      @artist_name = params["info"]["artist_details"]["name"]
      @search_count = params["info"]["search_count"]
      if @id == "6969"
        @beer = Beer.get_bud_light
      else
        @beer = Beer.get_beer_by_style(params[:info][:beer_id])
      end
      render 'index'
    end

  end

  def create
      if params["custom_search"]
        if params["description"].nil?
          flash[:error] = "You need to choose what you're in the mood for!"
          render 'new'
        else
          beer_type = params["description"]
          if params["search_count"]
            new_count = params[:search_count].to_i
            new_count += 1
            @search_count = new_count
          else
            @search_count = 1
          end
          @beer = Beer.get_by_description(beer_type)
          render 'show'
        end
      elsif params["more_of_the_same"]
        if params["search_count"]
          new_count = params[:search_count].to_i
          new_count += 1
          @search_count = new_count
        else
          @search_count = 1
        end
        @beer = Beer.get_beer_by_style(params[:beer_id])
        render 'show'
      else
        new_count = params[:search_count].to_i
        new_count += 1
        @song_title = params[:track_name]
        @search_count = new_count
        @artist_pic = params[:artist_pic]
        @artist_name = params[:artist_name]
        @id = params[:beer_id]
        @beer = Beer.get_beer_by_style(params[:beer_id])
        render "index"
      end

  end

  def new
    @beer = Beer.new

    flash[:error] = ""
    render 'new'
  end
end
