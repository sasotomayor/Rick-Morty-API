Rails.application.routes.draw do
  get 'characters/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'characters#index'
  resources :characters
end
