class CartsController < ApplicationController
  def show
    @order_items = current_order.order_items.includes(:listing)
    @images = Image.all
  end
end
