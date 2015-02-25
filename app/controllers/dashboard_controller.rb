class DashboardController < ApplicationController
  before_action :authenticate_user!
  def index
  	@listings = Listing.all.order('created_at DESC')
    @images = Image.all
  end

  def purchases
  end

  def items
    @listings = Listing.where(user_id: current_user.id).order('created_at DESC')
    @images = Image.all
  end

  def shoporders
  end

  def revenues
  end

  def users
  	@users = User.all
  end

end
