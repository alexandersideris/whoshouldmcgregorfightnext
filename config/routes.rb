Rails.application.routes.draw do
  get 'fights/index'
  resources :fights
  root 'fights#index'

end
