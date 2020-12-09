Rails.application.routes.draw do
  resources :sessions
  resources :users
  resources :feeds do
    collection do
      post :confirm
    end
  end
end
