Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  root "top#index"
  get "about" => "top#about", as: "about"
  get "bad_request" => "top#bad_request"
  get "internal_server_error" => "top#internal_server_error"
  get "lesson/:action(/:name)" => "lesson"


  resources :members, only: [:index, :show] do
    collection { get "search" }
    resources :entries, only: [:index]
  end
  resources :articles, only: [:index, :show]
  resources :entries do
  	# @like 「いいね」した時に「votes」テーブルにレコードを作成
  	# @unlike 自分の投票を削除
  	# @voted 自分の投票の記事一覧を表示
  	member { patch "like", "unlike" }
  	collection { get "voted" }
  end
  resource :session, only: [:create, :destroy]
  resource :account

  namespace :admin do
    root "top#index"
    resources :members do
      collection { get "search" }
    end
    resources :articles
  end

  match "*anything" => "top#not_found", via: [:get, :post, :patch, :delete]

end
