Rails.application.routes.draw do
  root to: 'lotteries#index'

  resources :lotteries
end
