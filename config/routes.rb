Rails.application.routes.draw do
	root 'static#home'

  	get '/home', to: 'static#home'

  	get '/help', to: 'static#help'
  	get  '/signup',  to: 'users#new'
  	resources :users


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
