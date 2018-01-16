Rails.application.routes.draw do
  # get 'users/index'

  # get 'users/show'

	root 'home#index'

	devise_for :users, controllers: {
		omniauth_callbacks: 'users/omniauth_callbacks'
	}
	resources :users, :only => [:index, :show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'entries/index'

  get 'entries/show'

  get 'entries/new'

  get 'entries/edit'

end
