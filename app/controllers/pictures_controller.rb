class PicturesController < ApplicationController
  before_filter :set_user, only: [:index, :new, :create, :edit, :update, :destroy]
  before_filter :set_picture, only: [:edit, :update, :destroy]
  before_filter :require_user, only: [:new, :create, :edit, :update, :destroy]
  before_filter :store_location, only: [:index]

  def index
    @pictures = Picture.where(user_id: @user)
    respond_to do |format|
      format.html { @pictures }
      format.json { render json: @pictures.to_json(include: [:user]) }
    end
  end

  def new
    @picture ||= Picture.new
    render
  end

  def create
    @picture = @user.pictures.new(picture_params)
    if @picture.save
      @picture.update_attributes(:state => "published")
      @picture.update_attributes(:published_at => Time.zone.now)

      random = [('a'..'z'), ('A'..'Z'), ('1'..'9')].map { |i| i.to_a }.flatten
      pid = (0...12).map { random[rand(random.length)] }.join
      @picture.update_attributes(:pid => pid)

      redirect_to view_path(@picture), notice: "New picture has been created."
    else
      render 'new'
    end
  end

  def show
    @picture = Picture.find(params[:id])
    respond_to do |format|
      format.html { @picture }
      format.json { render json: @picture.to_json(include: [:user]) }
    end

    @pictures = Picture.all.limit(4)
    @random = @pictures.random
    @picture.increment!(:views)
  end

  def edit
    if @picture
      render
    else
      redirect_to picture_path, notice: "Picture not found."
    end
  end

  def update
    if @picture.update(picture_params)
      redirect_to picture_path, notice: "#{@picture.title} has been updated."
    else
      render 'edit'
    end
  end

  def destroy
    @picture.destroy
    redirect_to pictures_path, notice: "Picture has been deleted."
  end

  private

  def set_user
    @user = current_user
  end

  def set_picture
    @picture = Picture.where(slug: params[:id], user: @user).take
  end
end