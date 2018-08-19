Rails.application.routes.draw do
  resources :users, only: :create, constraints: { format: 'json' } do
    get 'valid', on: :collection
    get 'watch_list', on: :member
    resources :watching_events, only: :create
  end
end
