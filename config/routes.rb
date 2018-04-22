Rails.application.routes.draw do
  resources :plants, shallow:true do
    resources :images, only: [:create, :destroy]
    resources :common_names, only: [:create, :destroy, :update]
  end

  get '/contact_us', to:'welcome#contact_us'
  get '/', to:'welcome#index', as:'home'

end
