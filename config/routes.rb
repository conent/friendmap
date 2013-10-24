Friendmap::Application.routes.draw do


  devise_for :friends
  resources :friendships
  resources :friend_requests do
      member do
            get 'accept/:otherfriend', to: 'friend_requests#accept', as: :accept
      end
  end


  match "/addFriend" => "mobile#addFriend", :via => [:get, :post]
  match "/confirmFriend" => "mobile#confirmFriend", :via => [:get, :post]
  match "/declineFriend" => "mobile#declineFriend", :via => [:get, :post]
  match "/deleteFriend" => "mobile#deleteFriend", :via => [:get, :post]
  match "/getFriendList" => "mobile#getFriendList", :via => [:get, :post]
  match "/locationUpdate" => "mobile#locationUpdate", :via => [:get, :post]
  match "/signin" => "mobile#signin", :via => [:get, :post]
  match "/signup" => "mobile#signup", :via => [:get, :post]
  match "/updateInfo" => "mobile#updateInfo", :via => [:get, :post]
  match "/uploadImage" => "mobile#uploadImage", :via => [:get, :post]
    
  


  get 'testformsi' => 'pages#testformsi', :via => [:get, :post]
  get 'about'=> 'pages#about'
  root :to => 'pages#home'


  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

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
