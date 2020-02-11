Rails.application.routes.draw do
  namespace :api, default: { format: :json } do
    namespace :v1 do
      resources :users, only: %i[show create update destroy]
      resources :tokens, only: %i[create]
      resources :products, only: %i[show create index update destroy]
    end
  end
end
