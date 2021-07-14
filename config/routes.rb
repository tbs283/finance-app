Rails.application.routes.draw do
  
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  
  get "mypage" => 'users#mypage'
  resources :goal, :only => [:new, :create, :edit, :update]
  resources :blogs, only: [:new, :create, :index, :show, :destroy] do
    resource :favorites, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end
  resources :users, :only => [:show, :edit, :update]
  resources :balances, :only => [:edit, :create, :index, :show, :new, :update, :destroy]
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to:'homes#top'
  
end
