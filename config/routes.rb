Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post 'auth/login', to: 'authentication#login'

  resources :beers do
  	collection {get :get_all_beers}
  	collection {get :get_beers_by_name}
  	collection {get :get_beers_by_avb}
  	collection {get :get_favorites}
  	collection {post :save_favorite_beer}
  end
end
