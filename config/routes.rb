Rails.application.routes.draw do
# root to: "homes#top"

root to: "homes#top"
devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
get 'home/about', to: 'homes#about', as: :about

patch 'ideas/:id' => 'ideas#update', as: 'update_idea'
resources :ideas, only: [:new, :create, :index, :show ,:edit, :destroy, :update]
resources :users, only: [:show, :edit, :update]

devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

end
