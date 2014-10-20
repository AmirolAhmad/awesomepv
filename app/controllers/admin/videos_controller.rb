class Admin::VideosController < ApplicationController
  before_filter :set_user, only: [:index, :edit, :update, :destroy]
  before_filter :set_video, only: [:edit, :update, :destroy]
  before_filter :store_location, only: [:index]
  before_filter :require_admin

  def index
    @videos = Video.where(user_id: @user)
    respond_to do |format|
      format.html { @videos }
      format.json { render json: @videos.to_json(include: [:user]) }
    end
  end

  def edit
    if @video
      render
    else
      redirect_to admin_user_videos_path, notice: "Video not found."
    end
  end

  def update
    if @video.update(video_params)
      redirect_to admin_user_videos_path, notice: "Video #{@video.vid} has been updated."
    else
      render 'edit'
    end
  end

  def destroy
    @video.destroy
    redirect_to admin_user_videos_path, notice: "Video has been deleted."
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_video
    @video = Video.where(slug: params[:id], user: @user).take
  end
end
