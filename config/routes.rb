Rails.application.routes.draw do
  get 'users/show'
  get 'users/edit'
  get 'users/update'
# root to: "homes#top"

root to: "homes#top"
devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
get 'home/about', to: 'homes#about', as: :about

resources :ideas, only: [:new, :create, :index, :show ,:edit]
end
