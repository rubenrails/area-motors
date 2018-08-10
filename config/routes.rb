Rails.application.routes.draw do
  root 'enquiries#index'
  resources :enquiries, only: [:index, :show, :update] do
    get 'load', on: :collection
  end
end
