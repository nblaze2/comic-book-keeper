Rails.application.routes.draw do
  resources :collectibles
  resources :users, only: [:index] do
    resources :collectibles, only: [:index]
  end
  devise_for :users, :controllers => { registrations: 'registrations' }
  get "/pages/:page" => "pages#show"
  root to: "home#index"
end
