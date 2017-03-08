Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  resources :users, only: [:index, :destroy] do
    resources :collectibles
    resources :searches
  end

  get "/pages/:page" => "pages#show"
  root to: "home#index"
end
