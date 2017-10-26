Rails.application.routes.draw do
  namespace :api do
    resources :uploads, only: [:create]
    resources :photos, only: [:index, :show]
  end

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
