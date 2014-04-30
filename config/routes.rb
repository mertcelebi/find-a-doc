FindADoc::Application.routes.draw do
  
  resources :users

  root  'static_pages#home'
  match '/signup',  to: 'users#new', via: 'get'
  match '/about_us', to: 'static_pages#about_us', via: 'get'

end
