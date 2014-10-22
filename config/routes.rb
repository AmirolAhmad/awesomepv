Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    delete 'sign_out', :to => 'devise/sessions#destroy'
    get '/login' => 'devise/sessions#new'
    get '/register' => 'devise/registrations#new'
  end
  get 'pages/index'

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

  get '/v=:id' => 'videos#show', as: 'watch' #example - awesomepv.dev/v=aNFo5HWC3QI
  get '/p=:id' => 'pictures#show', as: 'view'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'pages#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
