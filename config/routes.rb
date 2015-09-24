Rails.application.routes.draw do
  devise_for :users
  authenticated do
    root :to => 'posts#index', as: :authenticated
  end
  root 'static_pages#home'
  resources :posts do
    resources :comments
  end
end
