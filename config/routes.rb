ClioInOutStub::Application.routes.draw do

  resources :memberships


  resources :teams


  get "teams/index"

  devise_for :users

  resources :users, :only => [:index, :show, :edit, :update] do
    member do
      get :status
    end
  end
  resources :users do
    post :add_team, :on => :collection
  end
  root :to => "users#index"

  
end
