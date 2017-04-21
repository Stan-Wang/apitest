Apitest::Engine.routes.draw do
  # resources :apitest
  root to: 'apitest#index'
  get '/:id' , to: 'apitest#show'
end
