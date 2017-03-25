Rails.application.routes.draw do
  root to: 'recipes#show'

  resources :recipes
  resources :users
  get '/login', to: 'sessions#login_show'
  post "/login" => "sessions#login"
  get '/logout' => 'sessions#logout'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
