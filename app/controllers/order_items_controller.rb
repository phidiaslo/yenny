class OrderItemsController < ApplicationController
 
  def create
    @order = current_order
    @order_item = @order.order_items.new(order_item_params)
    @order_item.country = current_user.country
    @shiplocations = Shiplocation.where(listing_id: @order_item.listing_id)
    @delivery = @shiplocations.find_by_country(current_user.country)
    
    if @delivery.nil?
      redirect_to :back, notice: "Sorry! The seller does not deliver to #{current_user.country}"
    else
      @order_item.shipping_price = @delivery.cost
      @order.save
      session[:order_id] = @order.id
      redirect_to cart_path, notice: "Item has been added to cart successfully"
    end    
  end

  def update
    @order = current_order
    @order_item = @order.order_items.find(params[:id])
    @order_item.update_attributes(order_item_params)
    @order_items = @order.order_items
    redirect_to cart_path, notice: "Item has been updated successfully"
  end

  def destroy
    @order = current_order
    @order_item = @order.order_items.find(params[:id])
    @order_item.destroy
    @order_items = @order.order_items
    redirect_to :back, notice: "Item is deleted succesfully"
  end

  def find_shipping
    
  end
  
private
  def order_item_params
    params.require(:order_item).permit(:quantity, :choice, :country, :product_id, :listing_id, :shipping_price)
  end
end
