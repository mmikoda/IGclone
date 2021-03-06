Rails.application.routes.draw do
  resources :sessions
  resources :favorites
  resources :users
  resources :feeds do
    collection do
      post :confirm
    end
  end
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
