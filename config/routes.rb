Rails.application.routes.draw do
  namespace :api do
    resource :uploads, only: [:create]
  end

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
