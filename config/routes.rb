Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
    post 'users/admin_sign_in', to: 'users/sessions#new_admin'
  end
  root to: 'laundries#index'
  resources :laundries do
    resources :comments, only: [:create, :destroy]
    collection do
      get 'search'
    end
  end
  
end
