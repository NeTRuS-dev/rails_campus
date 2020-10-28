Rails.application.routes.draw do
  get 'statistics/index'
  get 'statistics/average'
  resources :marks
  resources :vacancies

  match 'employers/index', via: [:get, :post]
  match 'students/index', via: [:get, :post]
  match 'students/vacancies', via: [:get, :post]

  get 'managers/index'
  post 'managers/create_group'
  post 'managers/create_specialty'
  post 'managers/create_subject'
  post 'managers/create_skill'
  delete 'managers/delete_skill'
  delete 'managers/delete_group'
  delete 'managers/delete_specialty'

  get 'admins/index'
  root 'home#index'

  devise_for :users
end
