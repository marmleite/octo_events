Rails.application.routes.draw do
  get 'issues/:number/events', to: 'events#filter_issues_by_number'
  resources :events, only: [:create]
end
