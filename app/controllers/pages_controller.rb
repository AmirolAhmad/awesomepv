class PagesController < ApplicationController
  before_filter :store_location
  
  def index
  	@videos = Video.all.paginate(:page => params[:page])

    respond_to do |format|
      format.html {
        @carousel = @videos.published.featured.take(7)
  	    @published_only = @videos.published_only.take(7)
  	    @sub = @published_only.shift(4)
        @both = @carousel.shift(4)
      }
      format.js {
        @videos = @videos.published_only.take(7)
        render 'infinite_index'
      }
    end
  end
end
