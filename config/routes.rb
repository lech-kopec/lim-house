LimHouse::Application.routes.draw do
  
  resources :users
  resources :sessions, only:[:new,:create,:detroy]
  resources :products
  resources :auctions
  resources :clients
  #resources :prod_returns
  resources :prod_returns do
    member do
      put 'change_status'
    end
  end
  resources :comments


  match '/signin', to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete

  match '/prod_returns/show_edit', to: 'prod_returns#show_edit'
  match '/prod_returns/group_delete', to: 'prod_returns#group_delete'
  match '/prod_returns/group_delete_att', to: 'prod_returns#group_delete_att'
  match '/prod_returns_archive', to: 'prod_returns#archive'
  match '/prod_returns/delete_att', to: 'prod_returns#delete_att'
  match '/prod_returns/send_backup', to: 'prod_returns#send_backup'

  match '/search', to: 'prod_returns#search'


  root :to => 'static_pages#home'
  #get "static_pages/home"
  match '/help', to: 'static_pages#help'

  #match '/signup', to:'users#new'

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
