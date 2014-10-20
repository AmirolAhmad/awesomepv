class Admin::UsersController < ApplicationController
  before_filter :set_user, only: [:show, :edit, :update, :destroy]
  before_filter :store_location, only: [:index]
  before_filter :require_admin

  def index
    @users = User.all.order("created_at DESC")
    respond_to do |format|
      format.html { @users }
      format.json { render json: @users.to_json(include: [:profile]) }
    end
  end

  def edit
    if @user
      render
    else
      redirect_to admin_users_path, notice: "User profile not found."
    end
  end

  def show
    if @user
      respond_to do |format|
        format.html { @user }
        format.json { render json: @user.to_json(include: [:profile]) }
      end
    else
      redirect_to admin_users_path, notice: "User not found."
    end
  end

  def update
    # Rails.logger.debug "===> (1)"
    if @user.update(user_params)
      redirect_to admin_user_path, notice: "#{@user.profile.full_name} account has been updated."
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy

    redirect_to admin_users_path, notice: "Account has been deleted."
  end

  private

  def set_user
    @user = User.friendly.find(params[:id])
  end
end
