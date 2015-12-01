Rails.application.routes.draw do
  post '/buildings/upgrade', to: 'buildings#upgrade'
  get '/buildings/list', to: 'buildings#list'
  get '/buildings/levels', to: 'buildings#levels'

  get '/districts/info', to: 'districts#info'

  post '/users/login',  to: 'users#login'
  post '/users/logout', to: 'users#logout'
  post '/users/new', to: 'users#new'
end
