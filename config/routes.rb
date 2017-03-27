Rails.application.routes.draw do
  root to: 'recipes#index'
  get '/recipes/random', to: 'recipes#random'

  resources :recipes
  resources :users
  get '/login', to: 'sessions#login_show'
  post "/login" => "sessions#login"
  get '/logout' => 'sessions#logout'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
