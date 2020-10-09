Rails.application.routes.draw do
  devise_for :users
  root to: 'laundries#index'
  resources :laundries do
    resources :comments, only: [:create]
    collection do
      get 'search'
    end
  end
  
end
