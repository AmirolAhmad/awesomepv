class Admin::DashboardsController < ApplicationController
  before_filter :store_location, only: [:index]
  before_filter :require_admin
  
  def index
    @users = User.all.order("created_at DESC")
  end
end
