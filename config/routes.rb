Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'articles#index'
  # creates all of the RESTful routes for CRUD
  resources :articles do
    resources :comments
  end

  resources :tags  

  resources :authors
  #routes for creating author sessions which is how we authenticate
  resources :author_sessions, only: [:new, :create, :destroy]

  get 'login' => 'author_sessions#new'
  get 'logout' => 'author_sessions#destroy'
end
