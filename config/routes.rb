Rails.application.routes.draw do
  resources :greetings, only: [:new,:show]
end
