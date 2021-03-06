Rails.application.routes.draw do
  root 'sessions#new'
  resources :sessions, only: [:new, :create] do
    delete :sign_out, on: :collection
  end

  resources :users, only: [:show, :edit, :update]

  resources :companies, only: [:show, :edit, :update]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
