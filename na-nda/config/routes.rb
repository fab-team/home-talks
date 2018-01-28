Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # get 'users/index'

  # get 'users/show'

  # root 'home#index'
  get "about" => "home#about", as: "about"

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  resources :users, :only => [:index, :show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [:index, :show] do
    # @like 「いいね」した時に「votes」テーブルにレコードを作成
    # @unlike 自分の投票を削除
    # @voted 自分の投票の記事一覧を表示
    # member { patch "like", "unlike" }
    # collection { get "voted" }
    collection { get "search" }
    resources :entries, only: [:index]
  end

  get 'tags/:tag', to: 'entries#index', as: :tag
  resources :entries
  root 'entries#index'

  # get 'entries/index'

  # get 'entries/show'

  # get 'entries/new'

  # get 'entries/edit'

end
