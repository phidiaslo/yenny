Rails.application.routes.draw do

  get 'dashboard' => "dashboard#index"
  get 'purchases' => "dashboard#purchases"
  get 'customer-orders' => "dashboard#shoporders"
  get 'revenues' => "dashboard#revenues"
  get 'items' => "dashboard#items"

  get 'users' => "dashboard#users"
  get 'listings/update_subcategories', :as => 'update_subcategories'

  # Authentication
  devise_for :users, skip: [:sessions, :passwords, :confirmations, :registrations]
  as :user do
    # session handling
    get     '/login'  => 'devise/sessions#new',     as: 'new_user_session'
    post    '/login'  => 'devise/sessions#create',  as: 'user_session'
    delete  '/logout' => 'devise/sessions#destroy', as: 'destroy_user_session'

    # joining
    get   '/join' => 'devise/registrations#new',    as: 'new_user_registration'
    post  '/join' => 'devise/registrations#create', as: 'user_registration'

    scope '/account' do
      # password reset
      get   '/reset-password'        => 'devise/passwords#new',    as: 'new_user_password'
      put   '/reset-password'        => 'devise/passwords#update', as: 'user_password'
      post  '/reset-password'        => 'devise/passwords#create'
      get   '/reset-password/change' => 'devise/passwords#edit',   as: 'edit_user_password'

      # confirmation
      get   '/confirm'        => 'devise/confirmations#show',   as: 'user_confirmation'
      post  '/confirm'        => 'devise/confirmations#create'
      get   '/confirm/resend' => 'devise/confirmations#new',    as: 'new_user_confirmation'

      # settings & cancellation
      get '/cancel'   => 'devise/registrations#cancel', as: 'cancel_user_registration'
      get '/settings' => 'devise/registrations#edit',   as: 'edit_user_registration'
      put '/settings' => 'devise/registrations#update'

      # account deletion
      delete '' => 'devise/registrations#destroy'
    end
  end

  resource :cart, only: [:show] #ShoppingCart

  resources :order_items, only: [:create, :update, :destroy] #ShoppingCart
  
  resources :users, only: [:index, :show, :edit, :update]

  resources :states

  resources :images

  resources :subcategories

  resources :categories

  resources :listings do
    collection do
      match 'search' => 'listings#search', via: [:get, :post], as: :search
    end
  end

  root 'welcome#index'

end
