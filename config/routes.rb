Rails.application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:show] do
    resources :places, to: 'users#places'
  end

  resources :places do
  end

  root'welcome#home'

  # get '/signin', to:'sessions#new', as:'signin'
  # get '/places/home', to:'places#home'
  # get '/places/home', to:'places#home'
end
