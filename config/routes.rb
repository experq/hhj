Halloped::Application.routes.draw do

  get "/fail" => "pages#fail"
  get "/logout" => "pages#logout"
  get "/env" => "pages#environment"
  unless Rails.env.production?
    get "/dev_login" => "pages#dev_login"
    get "/dev_logout" => "pages#dev_logout"
    get "/dev_users" => "pages#dev_users"
  end

  devise_for :admins
  get "/admin" => redirect("/en/admin")

  scope "/:locale" do
    mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
  end

  scope "/:locale/:university" do

    resources :users, only: [:edit, :update]

    resources :calls do
      resources :position_applications
    end

    resources :alliance_memberships, only: [:update] do
    end

    resources :recommendations, only: [:create, :destroy]

    resources :alliances, only: [:index, :new, :create, :show]

    resources :organs do
      resources :calls
      resources :members
    end

    resources :organizations

    get "/global_status" => "pages#global_status"
  end


  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   get 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   get 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
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

  # News are not implemented yet so route university frontpage to open calls until
  # we have some content for the university frontpage
  #get ':locale/:university' => 'pages#university', :as => :university
  get ':locale/:university' => 'calls#index', :as => :university

  get ':locale' => 'pages#index', :as => :index


  root :to => 'pages#default_locale_redirect'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # get ':controller(/:action(/:id))(.:format)'
end
