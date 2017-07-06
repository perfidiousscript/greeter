Rails.application.routes.draw do
  resources :greeting, only: [:new,:show]
end
