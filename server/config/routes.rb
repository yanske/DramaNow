Rails.application.routes.draw do
  resources :users, only: :create, constraints: { format: 'json' }
end
