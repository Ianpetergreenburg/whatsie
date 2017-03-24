Rails.application.routes.draw do
  root to: 'recipes#show'

  resources :recipes
  resources :users
  get '/login', to: 'sessions#show'
  post "/login" => "sessions#create"
  get '/logout' => 'sessions#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
