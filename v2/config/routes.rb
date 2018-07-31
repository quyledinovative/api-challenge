Rails.application.routes.draw do
  namespace :api do
    namespace :v2 do
      resources :matches do
        collection do
          post :import
          get :show_player_result
        end
      end
    end
  end
end
