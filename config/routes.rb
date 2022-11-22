Rails.application.routes.draw do
  root               to: 'main#index'
  get  '/profile',   to: 'main#profile'
  get  '/logout',    to: 'main#logout'
  get  '/delete',    to: 'main#delete'
  post '/authorize', to: 'main#authorize'
end