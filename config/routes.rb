Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'ideas#index'
  resources :ideas do
    resources :reviews, only: [:create, :destroy, :index]
    resources :likes, only: [:create]

  end





  resources :users, only:[:new, :create, :update, :edit]
  resources :sessions, only:[:new, :create] do
    delete :destroy, on: :collection
  end
end
