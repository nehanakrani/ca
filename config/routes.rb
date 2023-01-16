Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :groups do
        post :assigned_users, on: :member
      end
      resources :users, except: [:create]
    end
  end
end