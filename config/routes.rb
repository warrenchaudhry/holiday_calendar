Rails.application.routes.draw do
  get 'main/index'
  get 'events', to: 'main#events'
  root to: 'main#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
