Rails.application.routes.draw do

  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  # GET '/reviews/:id/flag'(.:format)
  # PUT '/reviews/:id/flag'(.:format)
  resources :users
  resources :sessions
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :ideas do
    resources :reviews, only: [:create, :destroy, :flag]
    resources :likes, only: [:create, :destroy]
  end
  patch '/review/hide/:id', to: 'reviews#hide', as: 'review_hide'
  # post '/ideas/:idea_id/reviews/:id', to: 'reviews#flag'
  root "ideas#index"
end
