Friendmap::Application.routes.draw do


  devise_for :friends
  resources :friendships
  resources :friend_requests do
      member do
            get 'accept/:otherfriend', to: 'friend_requests#accept', as: :accept
      end
  end


  match "/addfriend" => "mobile#addFriend", :via => :post
  match "/confirmfriend" => "mobile#confirmFriend", :via => :post
  match "/declinefriend" => "mobile#declineFriend", :via => :post
  match "/deletefriend" => "mobile#deleteFriend", :via => :post
  match "/getfriendlist" => "mobile#getFriendList", :via => :post
  match "/locationupdate" => "mobile#locationUpdate", :via => :post
  match "/signin" => "mobile#signin", :via => :post
  match "/signup" => "mobile#signup", :via => :post
  match "/updateinfo" => "mobile#updateInfo", :via => :post
  match "/uploadimage" => "mobile#uploadImage", :via => :post
    
  


  get 'testformsi' => 'pages#testformsi', :via => :post
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
