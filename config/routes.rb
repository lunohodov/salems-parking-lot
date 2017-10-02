Rails.application.routes.draw do
  scope '/api' do
    resources :tickets, only: [:create, :show]
  end
end
