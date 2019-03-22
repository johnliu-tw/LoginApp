Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "users#index"

  resources :users do
    collection do
      get :logout
      post :login
    end    
  end

  resources :passwords, :except => [:show] do
    collection do
      get :check_reset_token
      get :edit
      post :reset_password
      post :update_password
    end
  end


  mount LetterOpenerWeb::Engine, at: "/letter_opener"

end
