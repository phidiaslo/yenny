class WelcomeController < ApplicationController

  def index
  	@categories = Category.all
  	@listings = Listing.all.includes(:user)
  	@images = Image.all
  end

end