Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'main#index'

  get "/user/login" => "sessions#new", :as => "login"
  get "/user/sign_up" => "sessions#sign_up", :as => "new_user_registration"
  delete "/user/logout" => "sessions#destroy", :as => "logout"
  post "/user/create" => "sessions#create", :as => "user_account_create"
  post "/user/sign_in" => "sessions#sign_in", :as => "user_sign_in"

  get "/user/dashboard" => "users#dashboard", as: :user_dashboard
  get "/user/index" => "users#index", as: :user_index
  get "/user/show" => "users#show", as: :user_show

  get "/todo/index" => "todo#index", as: :todo_info
  post "/todo/create" => 'todo#create', as: :todo_create
  post "/todo/edit" => 'todo#edit', as: :todo_edit
  get "/todo/edit/:id" => 'todo#edit_todo', as: :todo_update


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
