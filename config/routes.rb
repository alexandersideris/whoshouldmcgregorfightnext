Rails.application.routes.draw do

  get 'sessions/create'

  get 'sessions/destroy'

  get 'fights/index'

  get 'fights/vote'
  
  get 'fights/unvote'

  get 'fights/subscribe'

  get 'fights/get_fights'

  resources :fights

  root 'fights#index'
  get '/privacypolicy/', to: 'privacypolicys#index'


  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'

  resources :sessions, only: [:create, :destroy]

end
