Rails.application.routes.draw do
  scope '/api' do
    resources :tickets, param: :barcode, only: [:create, :show] do
      get 'state', on: :member
      resources :payments, only: [:create]
    end
    get 'free-spaces', to: 'vacancy#show'
  end
end
