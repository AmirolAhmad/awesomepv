class VideosController < ApplicationController
  before_filter :set_user, only: [:index, :new, :create, :edit, :update, :destroy]
  before_filter :set_video, only: [:edit, :update, :destroy]
  before_filter :require_user, only: [:new, :create, :edit, :update, :destroy]
  before_filter :store_location, only: [:index]

  def index
    @videos = Video.where(user_id: @user)
    respond_to do |format|
      format.html { @videos }
      format.json { render json: @videos.to_json(include: [:user]) }
    end
  end

  def new
    @video ||= Video.new
    render
  end

  def create
    @video = @user.videos.new(video_params)
    if @video.save
      @video.update_attributes(:state => "published")
      @video.update_attributes(:published_at => Time.zone.now)

      redirect_to videos_path, notice: "New video has been created."
    else
      render 'new'
    end
  end

  def show
    @video = Video.find(params[:id])
  end

  def edit
    if @video
      render
    else
      redirect_to video_path, notice: "Video not found."
    end
  end

  def update
    if @video.update(video_params)
      redirect_to video_path, notice: "#{@video.title} has been updated."
    else
      render 'edit'
    end
  end

  private

  def set_user
    @user = current_user
  end

  def set_video
    @video = Video.where(slug: params[:id], user: @user).take
  end
end
