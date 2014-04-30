FindADoc::Application.routes.draw do
  
  resources :users
  resources :sessions, only: [:new, :create, :destroy]

  root  'static_pages#home'
  match '/about_us', to: 'static_pages#about_us', via: 'get'
  match '/signup',  to: 'users#new', via: 'get'
  match '/signin',  to: 'sessions#new', via: 'get'
  match '/signout', to: 'sessions#destroy', via: 'delete'

end
