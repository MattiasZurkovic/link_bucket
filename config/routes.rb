Rails.application.routes.draw do
  resources :comments
  devise_for :users
  resources :links do
    member do
      put "like", to: "links#upvote"
      put "dislike", to: "links#downvote"
    end
    member { post :vote }
    resources :comments
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  match '/new', :to => 'links#index', :via => :get
  match '/old', :to => 'links#oldest', :via => :get
  match '/popular', :to => 'links#hottest', :via => :get

  root to: 'links#index'

end
