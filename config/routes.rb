Rails.application.routes.draw do
  root to: 'lotteries#index'

  resources :lotteries do
    patch 'draw'
    get 'presentation'
    controller :candidates do
      get 'candidates', action: 'index'
      get 'candidates/winners', action: 'winners'
      put 'candidates', action: 'update'
      get 'candidates/edit', action: 'edit'
      get 'candidates/bulk_edit', action: 'bulk_edit'
      put 'candidates/bulk_update', action: 'bulk_update'
    end
  end
end
