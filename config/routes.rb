Rails.application.routes.draw do

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'event#index'

  resources :event do
  	resources :attendance
    resources :image, only: [:create]
  end

  resources :user, only: [ :show ] do
    resources :avatar, only: [:create]
  end

end
