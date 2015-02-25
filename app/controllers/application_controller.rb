class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_order

  before_filter :set_global_search_variable
  before_filter :set_global_categories_variable
  before_action :configure_permitted_parameters, if: :devise_controller?

  def set_global_search_variable
    @search = Listing.includes(:user).search(params[:q])
  end

  def set_global_categories_variable
    @categories = Category.all.order(:name)
    @states = State.all.order(:name)
    @users = User.all

    fresh_when last_modified: @categories.maximum(:updated_at)
    fresh_when last_modified: @states.maximum(:updated_at)
  end

  def current_order
    if !session[:order_id].nil?
      Order.find(session[:order_id])
    else
      Order.new
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:first_name, :last_name, :gender, :role, :username, :email, :password, :password_confirmation) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:email, :password) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:email, :password, :password_confirmation, :current_password)}
  end
end




 