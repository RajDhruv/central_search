Rails.application.routes.draw do
	root "home#index"
  resources :home do
    get :index
  end
  resources :search do
    collection do
      get :fetch_list
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
