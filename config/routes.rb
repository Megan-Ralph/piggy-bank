Rails.application.routes.draw do
  root "transactions#index"

  resources :transactions do
    get '/page/:page', action: :index, on: :collection
  end
end
