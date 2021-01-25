Rails.application.routes.draw do

  root 'tests#index'

  devise_for :users, path: :gurus, path_names: { sign_in: :login, sign_out: :logout }

  resources :tests, only: :index do
    member do
      post :start
    end
  end

  resources :test_passages, only: [:show, :update] do
    member do
      get :result
      post :gist
    end
  end

  get 'feedback', to: 'pages#feedback'
  post 'feedback', to: 'pages#send_feedback'

  get 'badges', to: 'badges#all'
  get 'badges_user', to: 'badges#user'

  namespace :admin do
    resources :tests do
      patch :update_inline, on: :member

      resources :questions, shallow: true, except: :index do
        resources :answers, shallow: true, except: :index
      end
    end

    resources :gists, only: :index

    resources :badges, except: :show
  end
end
