Rails.application.routes.draw do
  namespace :admin do
    resources :dashboard, only: [:index]
  end

  resource :session, only: [:new, :create, :destroy]
  resources :users, except: [:index] #include index when you add admin priveleges to view all existing users

  resources :individual_plants, except: [:index, :show] #the index is on user profile, and the show should be in a modal
  patch '/individual_plants/:id/generate', to:'individual_plants#generate_data', as: 'generate_data'

  resources :plants, shallow:true do
    resources :images, only: [:create, :destroy]
    resources :common_names, only: [:create, :destroy, :update]
  end

  get '/contact_us', to:'welcome#contact_us'
  get '/climate_zones', to:'welcome#climate_zones'
  get '/', to:'welcome#index', as:'home'

end
