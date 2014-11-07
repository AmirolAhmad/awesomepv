class Admin::PicturesController < ApplicationController
  before_filter :set_user, only: [:index, :edit, :update, :destroy]
  before_filter :set_picture, only: [:edit, :update, :destroy]
  before_filter :store_location, only: [:index]
  before_filter :require_admin

  def index
    @pictures = Picture.where(user_id: @user)
    respond_to do |format|
      format.html { @pictures }
      format.json { render json: @pictures.to_json }
    end
  end

  def edit
    if @picture
      render
    else
      redirect_to admin_user_pictures_path, notice: "Picture not found."
    end
  end

  def update
    if @picture.update(picture_params)
      redirect_to admin_user_pictures_path, notice: "Picture #{@picture.pid} has been updated."
    else
      render 'edit'
    end
  end

  def destroy
    @picture.destroy
    redirect_to admin_user_pictures_path, notice: "Picture has been deleted."
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_picture
    @picture = Picture.where(slug: params[:id], user: @user).take
  end
end
