Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root to: 'index#index'

  namespace :api, :defaults => {:format => :json} do
    namespace :v1 do
      resources :users, only: [:show, :create, :update, :destroy]
      get 'api_key_by_email' => 'users#api_key_by_email'
      
      resource :quotes, only: [:show, :index]
      get 'tickets_list'   => 'quotes#tickets_list'
      get 'avalable_dates' => 'quotes#avalable_dates'
    end
  end
end
