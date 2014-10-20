class AccountsController < ApplicationController
  before_filter :set_user, only: [:edit, :update, :destroy]
  before_filter :require_user

  def show
    @users = current_user

    respond_to do |format|
      format.html { @user }
      format.json { render json: @user.to_json(include: [:user]) }
    end
  end

  def edit
    if @user
      render
    else
      redirect_to account_path, notice: "Your profile not found."
    end
  end

  def update
    if @user.update(user_params)
      redirect_to account_path, notice: "#{@user.profile.full_name} account has been updated."
    else
      render 'edit'
    end
  end

  private

  def set_user
    @user = current_user
  end

end
