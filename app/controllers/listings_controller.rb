class ListingsController < ApplicationController
  before_action :set_listing, only: [:show, :edit, :update, :destroy]

  def index
    @listings = Listing.all.order('created_at DESC').includes(:user)
    @images = Image.all
  end

  def search
    @listings = @search.result.includes(:user).to_a.uniq
    @images = Image.all
  end

  def show
    @images = Image.where(listing_id: @listing)
    @listings = Listing.where(user_id: @listing.user_id)
    @related = @listings.where.not(id: @listing ).includes(:user, :images).limit(5)
    @choices = Variation.where(listing_id: @listing).pluck(:name)
    @shiplocations = Shiplocation.where(listing_id: @listing)

    @order_item = current_order.order_items.new #ShoppingCart

    if user_signed_in?
      if (current_user.id != @listing.user_id) && (current_user.role != 'Admin')
        @listing.increment!(:view_count)
      end
    else
      @listing.increment!(:view_count)
    end
  end

  def new
    @listing = Listing.new
    @subcategories = Subcategory.all

    @listing.variations.build
    @listing.images.build
    @listing.shiplocations.build
  end

  def edit
    @subcategories = Subcategory.all
  end

  def create
    @listing = Listing.new(listing_params)
    @listing.user_id = current_user.id

    respond_to do |format|
      if @listing.save
        format.html { redirect_to listings_path, notice: 'Listing was successfully created.' }
        format.json { render :show, status: :created, location: @listing }
      else
        format.html { render :new }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @listing.update(listing_params)
        format.html { redirect_to listings_path, notice: 'Listing was successfully updated.' }
        format.json { render :show, status: :ok, location: @listing }
      else
        format.html { render :edit }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @listing.destroy
    respond_to do |format|
      format.html { redirect_to listings_url, notice: 'Listing was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def update_subcategories
    category = Category.find(params[:category_id])
    @subcategories = category.subcategories.map{|a| [a.name, a.id]}.insert(0, "Select Subcategory")
  end

  private
    def set_listing
      @listing = Listing.friendly.find(params[:id])
    end

    def listing_params
      params.require(:listing).permit(:name, :description, :price, :quantity, :processing_time, :view_count, :status, :user_id, :category_id, :subcategory_id, :state_id, :slug, images_attributes: [ :id, :photo, :_destroy ], variations_attributes: [:id, :name, :stock, :_destroy], shiplocations_attributes: [:id, :country, :price, :cost, :_destroy])
    end
end
