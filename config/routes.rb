Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  get "report" => 'reports#index'
  get "yearbalance" => 'reports#yearbalance'
  get "yeargenre" => 'reports#yeargenre'
  get "totalsaving" => 'reports#totalsaving'
  get "cashflow" => 'reports#cashflow'
  get "mypage" => 'users#mypage'
  get "register" => 'balances#register'
  resources :budgets, only: [:new, :create, :edit, :update, :index, :destroy]
  resources :blogs, only: [:new, :create, :edit, :update, :show, :destroy] do
    get :search, on: :collection
    resource :favorites, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end
  resources :users, :only => [:show, :edit, :update]
  resources :balances, :only => [:edit, :create, :index, :show, :update, :destroy] do
  end
  post 'follow/:id' => 'relationships#follow', as: 'follow'
  post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow'
  resources :users, only: :show


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to:'homes#top'

end
