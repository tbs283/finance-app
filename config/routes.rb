Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  devise_for :users, skip: :all 
  
  get "users/goal/edit" => 'users#goal_edit'
  get "users/goal" => 'users#goal'
  get "mypage" => 'users#mypage'
  post 'users/goal' => 'users#create'
  patch 'users/goal' => 'users#update'
  resources :users, :only => [:show, :edit]
  resources :blogs
  
  devise_scope :user do
    get 'users/index', to: 'users/registrations#index'
    get 'users/destroy', to: 'users/sessions#destroy'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to:'homes#top'
end
