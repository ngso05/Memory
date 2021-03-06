Rails.application.routes.draw do
  get 'users/show'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'memos#index'
  resources :memos
  resources :users, only: [:show, :edit, :update] do
    collection do
      get 'withdraw'
      patch 'withdraw'
      get 'unsubscribe'
    end
  end
end
