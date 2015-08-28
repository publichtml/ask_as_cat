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
      get 'candidates/import', action: 'import_form'
      put 'candidates/import', action: 'import'
    end
  end
end
