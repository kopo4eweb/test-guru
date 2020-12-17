Rails.application.routes.draw do
  resources :answers
  resources :tests do
    resources :questions, shallow: true, except: :index
  end
end
