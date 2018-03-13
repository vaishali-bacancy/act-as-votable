Rails.application.routes.draw do
  
	root "posts#new"
	devise_for :users
	resources :posts do 
  member do
    put "like", to: "posts#like"
    put "dislike", to: "posts#dislike"
  end
end
 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
