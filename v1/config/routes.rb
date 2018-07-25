Rails.application.routes.draw do
  resources :tournaments
  resources :achievements

  get 'csv_files/show_matches', to:'csv_files#show_matches'
  get 'player_matches/show_points', to:'player_matches#show_points'
  get 'matches/filter_by', to:'matches#filter_by'
  get 'csv_files/show_points/:player_name', to:'csv_files#show_points'
  # get 'csv_files/show_matches/:match_code', to:'csv_files#show_matches'
  # get 'csv_files/show_matches/:match_code', to:'csv_files#show_matches'
  resources :player_matches
  resources :matches
  resources :venues do
    collection {post :import}
  end
  resources :players do
    collection {post :import}
  end
  resources :groups do
    collection {post :import}
  end
  resources :csv_files do
    collection {post :import}
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
