Rails.application.routes.draw do
  resources :plants 

  get '/contact_us', to:'welcome#contact_us'
  get '/', to:'welcome#index', as:'home'

end
