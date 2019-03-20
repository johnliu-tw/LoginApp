Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users
  resources :passwords, :except => [:show]

  root "users#index"
  get  'logout', :to => 'users#logout'
  post  'login', :to => 'users#login'
  get   'passwords/reset_password', :to => 'passwords#check_reset_token'
  get   'passwords/edit', :to => 'passwords#edit'
  post  'passwords/reset_password', :to => 'passwords#reset_password'
  post  'passwords/update', :to => 'passwords#update'


  mount LetterOpenerWeb::Engine, at: "/letter_opener"

end
