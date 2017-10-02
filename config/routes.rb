Rails.application.routes.draw do
  scope '/api' do
    resources :tickets, only: [:create, :show] do
      resources :payments, only: [:create]
    end
  end
end
