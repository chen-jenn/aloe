Rails.application.routes.draw do
  resources :plants, shallow:true do
    resources :images, only: [:create, :destroy] do
    end 
  end

  get '/contact_us', to:'welcome#contact_us'
  get '/', to:'welcome#index', as:'home'

end
