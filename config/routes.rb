Rails.application.routes.draw do
  namespace :staff do
    root "top#index"
    get "login" => "session#new", as: :login
    post "session" => "sessions#create", as: :session
    delete "session" => "session#destroy"
  end

  namespace :admin do
    root "top#index"
  end

  namespace :customer do
    root "top#index"
  end
end
