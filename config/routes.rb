Rails.application.routes.draw do
  scope :read_write do
    get :fetch, to: "read_write#fetch"
    post :not_safe, to: "read_write#not_safe"
    post :safe, to: "read_write#safe"
  end

  scope :write_write do
    get :fetch, to: "write_write#fetch"
    post :not_safe, to: "write_write#not_safe"
    post :safe, to: "write_write#safe"
  end

  resources :forms, except: [ :show, :delete ]

  scope :read do
    get :not_safe, to: "read#not_safe"
    get :safe, to: "read#safe"
  end

  scope :write do
    get :fetch, to: "write#fetch"
    post :create, to: "write#create"
  end

  scope :read_read do
    get :not_safe_1, to: "read_read#not_safe_1"
    get :not_safe_2, to: "read_read#not_safe_2"
    get :safe, to: "read_read#safe"
  end
end
