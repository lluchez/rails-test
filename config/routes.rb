Rails.application.routes.draw do
  resources :todos do
    get 'test'
  end
  root 'home#index'
end
