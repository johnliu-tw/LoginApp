Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users
  root "users#index"
  get  'logout', :to => 'users#logout'
  post  'login', :to => 'users#login'

  mount LetterOpenerWeb::Engine, at: "/letter_opener"

end
