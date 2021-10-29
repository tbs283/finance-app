Rails.application.routes.draw do
  
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  
  get "mypage" => 'users#mypage'
  get "income" => 'balances#income'
  get "expense" => 'balances#expense'
  resources :blogs, only: [:new, :create, :edit, :update, :index, :show, :destroy] do
    resource :favorites, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end
  resources :users, :only => [:show, :edit, :update]
  resources :balances, :only => [:edit, :create, :index, :show, :update, :destroy] do
  end
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to:'homes#top'
  
end
