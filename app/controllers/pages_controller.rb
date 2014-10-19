class PagesController < ApplicationController
  before_filter :store_location
  
  def index
  	@videos = Video.all.paginate(:page => params[:page])

  	@carousel = @videos.published.featured.take(5)
    @published_only = @videos.published_only.take(7)
    @sub = @published_only.shift(4)
  end
end
