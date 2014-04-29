FindADoc::Application.routes.draw do
  
  root  'static_pages#home'
  match '/about_us', to: 'static_pages#about_us', via: 'get'

end
