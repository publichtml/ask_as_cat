Rails.application.routes.draw do
  root to: 'lotteries#index'

  resources :lotteries do
    patch 'draw'
    controller :candidates do
      get 'candidates', action: 'index'
      put 'candidates', action: 'update'
      get 'candidates/edit', action: 'edit'
    end
  end
end
