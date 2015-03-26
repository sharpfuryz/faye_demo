Rails.application.routes.draw do
  get 'dashboard/index'
  get 'streaming/online'
  root 'dashboard#index'
end
