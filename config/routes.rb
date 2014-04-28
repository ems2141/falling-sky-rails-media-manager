Rails.application.routes.draw do

  root 'welcome#index'
  get '/pictures', to: 'pictures#index'
  get '/pictures/new', to: 'pictures#new'
  resources :videos

end
