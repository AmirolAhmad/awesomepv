Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    delete 'sign_out', :to => 'devise/sessions#destroy'
    get '/login' => 'devise/sessions#new'
    get 'register' => 'devise/registrations#new'
  end
  resources :posts
  get 'welcome/index'

  root 'posts#index'

end
