Rails.application.routes.draw do
  devise_for :installs
  devise_for :users, controllers: {sessions: 'sessions'}

  root 'pages#home', id: 'home'

  # Other Pages
  get '/list', to: 'pages#list'
  get '/terms', to: 'boilerplate#terms'
  get '/home', to: redirect('/')
  get '/admin', to: 'admin#index'
  get '/users/:id/edit', to: redirect('/users')
  get "/health_check", to: 'system_monitoring#health_check'

  resources :deployment_info, :only => [:index]

  scope :admin do
    resources :users, :states, :groupings, :notices, :regions, :institutions
  end

  # Catch-all, redirect to root
  get '*path', :to => redirect(path: '/', status: 302)
end
