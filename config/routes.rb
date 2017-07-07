Rails.application.routes.draw do
  resources :greetings, only: :new
  post 'greetings/display', to: 'greetings#display'
end
