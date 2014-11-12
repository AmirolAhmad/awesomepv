Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    delete 'sign_out', :to => 'devise/sessions#destroy'
    get '/login' => 'devise/sessions#new'
    get '/register' => 'devise/registrations#new'
  end

  get 'pages/index'  

  scope "/:locale" do

    namespace :admin, path: '/master' do
      get "/" => "dashboards#index", as: 'master'
      resources :dashboards, only: [:index]
      resources :users do
        resources :videos, only: [:index, :edit, :update, :destroy]
        resources :pictures, only: [:index, :edit, :update, :destroy]
      end
    end

    resource :account, only: [:show, :edit, :update]
    resources :pictures do
      collection do
        get 'next_stories'
      end
    end
    resources :videos do
      collection do
        get 'next_stories'
      end
    end
    
  end

  get '/v=:id' => 'videos#show', as: 'watch' #example - awesomepv.dev/v=aNFo5HWC3QI
  get '/p=:id' => 'pictures#show', as: 'view'

  root 'pages#index'
  
end
