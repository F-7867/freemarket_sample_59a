Rails.application.routes.draw do
  devise_for :users,controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    sessions: 'users/sessions',
    registrations: "users/registrations",
  }
  devise_scope :user do
    get 'signups/sms_authentication', to: 'users/registrations#sms_authentication'
    post 'signups/sms_authentication', to: 'users/registrations#sms_authentication_create'
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end

  root 'products#index'

  resources :products do
    collection do
      get "category_children", defaults: { format: 'json' }
      get "category_grandchildren", defaults: { format: 'json' }
      get 'get_image', defaults: { format: 'json' }
      get 'header_second_category', defaults: { format: 'json' }
      get 'header_third_category', defaults: { format: 'json' }
    end
    member do
      get 'detail'
    end
  end

  resources :mypages, only: [:index] do
    collection do
      get 'logout'
      get 'listing'
      get 'card'
    end
    member do
      get 'profile'
      post 'update_profile'
      get 'identification'
      post 'update_identification'
    end
  end

  resources :users, only: [:index] do
    collection do
      get 'done'
    end
  end

  resources :addresses, only: [:index]

  resources :cards, only: [:new, :create, :destroy] do
    collection do
      get 'new_card'
      post 'pay'
    end
  end

  resources :purchases, only: [:show] do
    member do
      post 'pay'
      get 'done'
    end
  end

  resources :searches, only: [:index]

  resources :categories, only: [:index, :show]
end
