Rails.application.routes.draw do

  root 'welcome#index'

  get '/pictures', to: 'pictures#index'

  get '/videos', to: 'videos#index'

  get '/pictures/new', to: 'pictures#new'
end
