Rails.application.routes.draw do
  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }

  namespace :admin do
   root to: 'homes#top'
   get 'dashboards', to: 'dashboards#index'
   resources :users, only: [:index, :destroy]
   get 'ideas', to: 'ideas#index'
   resources :ideas, only: [:index, :destroy]
  end

  devise_for :users, controllers: {
    registrations: 'users/registrations'
    }

  scope module: :public do
    root to: 'homes#top'
    get 'homes/about', to: 'homes#about', as: :about
      resources :ideas, only: [:new, :create, :index, :show, :destroy, :edit ,:update] do
      resource :favorites, only: [:create, :destroy]
      resources :idea_comments, only: [:create, :destroy]

    end
     resources :users, only: [:show, :edit, :update ,:index]
  end

     resources :groups, only: [:new, :create, :index, :show, :destroy, :edit ,:update]
# root to: "homes#top"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
# get 'home/about', to: 'homes#about', as: :about

patch 'ideas/:id' => 'ideas#update', as: 'update_idea'
get "search" => "public/searches#search"
resources :ideas, only: [:new, :create, :index, :show ,:edit, :destroy, :update]do
    resource :favorite, only: [:create, :destroy]
    resources :idea_comments, only: [:create, :destroy]
end
resources :users, only: [:show, :edit, :update, :index]

devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

end
