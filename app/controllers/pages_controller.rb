class PagesController < ApplicationController
  before_filter :store_location
  
  def index
  	@videos = Video.all.paginate(:page => params[:page])
    @pictures = Picture.all.paginate(:page => params[:page])

    respond_to do |format|
      format.html {
        @both = @videos.published.featured.take(9)
  	    @published_only = @videos.published_only.take(7)
  	    @sub = @published_only.shift(4)
        @carousel = @both.shift(4)
      }
      format.js {
        @videos = @videos.published_only.take(7)
        render 'infinite_index'
      }
    end
  end
end
