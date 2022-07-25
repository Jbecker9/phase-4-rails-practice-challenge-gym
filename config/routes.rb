Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :gyms, only: [:index, :show, :create, :destroy] do
  resources :memberships, only: [:create]
  end
end
