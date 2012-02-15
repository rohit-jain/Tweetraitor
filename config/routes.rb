HttFinal::Application.routes.draw do
  resources :feedbacks

  resources :guests

  resources :sessions
  
  root :to => "home#index"

  match "/signout" => "sessions#destroy", :as => :signout  
  match "/guest_signout" => "guests#destroy", :as => :signout  
  match "/auth/:provider/callback" => "sessions#create"
  match "/sessions/show" => "sessions#show"
  match "/trend/:id" => "sessions#trend#id"
  match "/pt", :to => 'sessions#putToken'
  match "/save_tweet" => "save_tweet#create"
  match "/play" => "sessions#play"
  match "/filter" => "sessions#filter"
  match "/feedback" => "feedbacks#new"
  match "/view/xyz" => "feedbacks#index"
  match "/guest" => "guests#create"    
  match "/ghome" => "guests#show"
  match "/gplay" => "guests#play"    
  match "/guest_pt(/:id)", :to => 'guests#putToken#id'
  match "/gresult" => "guests#result"
  match "/result" => "sessions#result"
end
