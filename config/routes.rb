Rails.application.routes.draw do

  root 'welcome#index'

  get '/pictures', to: 'pictures#index'

  resources :videos

  #get '/videos', to: 'videos#index'
  #get '/videos/new', to: 'videos#new'

end
