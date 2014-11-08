class VideosController < ApplicationController
  require 'mixpanel-ruby'
  tracker = Mixpanel::Tracker.new(6ee4a30b269d81d1b42c85725fbff03a)

  before_filter :set_user, only: [:index, :new, :create, :edit, :update, :destroy]
  before_filter :set_video, only: [:edit, :update, :destroy]
  before_filter :require_user, only: [:index, :new, :create, :edit, :update, :destroy]
  before_filter :store_location, only: [:index]

  def index
    @videos = Video.where(user_id: @user)
    respond_to do |format|
      format.html { @videos }
      format.json { render json: @videos.to_json }
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

      random = [('a'..'z'), ('A'..'Z'), ('1'..'9')].map { |i| i.to_a }.flatten
      vid = (0...12).map { random[rand(random.length)] }.join
      @video.update_attributes(:vid => vid)

      redirect_to watch_path(@video), notice: "New video has been created."
    else
      render 'new'
    end
  end

  def show
    @video = Video.find(params[:id])
    tracker.track(id, 'Video Play')
    respond_to do |format|
      format.html { @video }
      format.json { render json: @video.to_json }
    end

    @videos = Video.all.limit(4)
    @random = @videos.random
    @video.increment!(:views)
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

  def destroy
    @video.destroy
    redirect_to videos_path, notice: "Video has been deleted."
  end

  private

  def set_user
    @user = current_user
  end

  def set_video
    @video = Video.where(slug: params[:id], user: @user).take
  end
end
