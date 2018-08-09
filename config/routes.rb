Rails.application.routes.draw do
  root 'enquiries#index'
  resources :enquiries, only: [:index, :show, :update]
end
