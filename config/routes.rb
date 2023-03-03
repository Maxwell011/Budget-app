Rails.application.routes.draw do
  get 'splash/index'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  devise_scope :user do 
    authenticated :user do 
      root 'groups#index', as: :authenticated_root
    end
    unauthenticated :user do 
      root 'splash#index', as: :unauthenticated_root
    end
  end
  # Defines the root path route ("/")
  # root 'users#splash'

  resources :users, only: [:splash]
  resources :groups, only: [:index, :new, :create, :edit, :update, :destroy], :path => "categories" do
    resources :expenses, only: [:index, :new, :create, :edit, :update, :destroy], :path => "transactions"
  end
end
