NinetyNineCatsDay1::Application.routes.draw do
  resources :users, only: [:create, :new]
  resources :session, only: [:create, :new, :destroy]

  resources :cats, except: :destroy
  resources :cat_rental_requests, only: [:create, :new] do
    post "approve", on: :member
    post "deny", on: :member
  end

  root to: redirect("/cats")
end
