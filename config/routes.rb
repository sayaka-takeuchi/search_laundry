Rails.application.routes.draw do
  devise_for :users
  root to: 'laundries#index'
  resources :laundries do
    resources :comments, only: [:create, :destroy]
    collection do
      get 'search'
    end
  end
  
end
