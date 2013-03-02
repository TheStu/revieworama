Revieworama::Application.routes.draw do

  resources :users, only: :show
  devise_for :users, :path_prefix => 'd'

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  root to: 'statics#home'
  match '/about', to: 'statics#about'
  match '/contact', to: 'statics#contact'
  match '/privacy', to: 'statics#privacy'
  match '/faq', to: 'statics#faq'
  match '/how-it-works', to: 'statics#how', as: 'how'

  resources :products, shallow: true do
    resources :questions, shallow: true do
      resources :answers
    end
    resources :reviews, shallow: true do
      resources :comments
    end
  end
  resources :alerts
  resources :vote

end
