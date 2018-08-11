Rails.application.routes.draw do
  root 'enquiries#index'
  resources :enquiries, only: [:index, :show, :update] do
    collection do
      get 'load'
      get 'search'
    end
  end
end
