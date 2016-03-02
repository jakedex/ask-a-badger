Rails.application.routes.draw do
  get 'answers/create'

  get 'answers/new'

  # get 'questions/update'

  # get 'questions/edit'

  # get 'questions/destroy'

  get 'questions/:id' => 'questions#show'
  get 'questions' => 'questions#index'
  get 'questions/index' => 'questions#index'
  post 'quesitons/:id' => 'answers#create'

  get 'questions/show'

  get 'preusers/new'

  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }
  get 'users/new'

  root 'static_pages#home'
  get 'signup' => 'users#new'
  get 'static_pages/faq'

  post 'twilio/reply' => 'twilio#reply'
  post 'twilio/send_msg' => 'twilio#send_msg'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
  #   namespace :admin d
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
