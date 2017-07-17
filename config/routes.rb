Rails.application.routes.draw do
  get :fetch, to: "locks#fetch"
  post :not_safe, to: "locks#not_safe"
  post :safe, to: "locks#safe"
end
