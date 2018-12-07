Rails.application.routes.draw do


  # Private API Endpoints
  namespace :api do
    namespace :v1 do
      resources :shelters
    end
  end

  namespace :api do
    namespace :v1 do
      resources :workers
    end
  end


  # Public API Endpoints
  namespace :api do
    namespace :v1 do
      resources :animals
    end
  end

  namespace :api do
    namespace :v1 do
      resources :adoption_requests
    end
  end

  post 'user_token' => 'user_token#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
