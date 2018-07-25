Rails.application.routes.draw do
  namespace :api do
    namespace :v2 do
      resources :venues
      resources :matches do
        collection do
          post :import
          get :show_player_result
        end
      end
      resources :tournaments
      resources :players
      resources :groups
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
