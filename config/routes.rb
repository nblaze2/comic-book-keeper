Rails.application.routes.draw do
  resources :collectibles

  devise_for :users, :controllers => { registrations: 'registrations' }
  root to: "home#index"
end
