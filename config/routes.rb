Rails.application.routes.draw do
  scope "read_write" do
    get :fetch, to: "read_write#fetch"
    post :not_safe, to: "read_write#not_safe"
    post :safe, to: "read_write#safe"
  end

  scope "write_write" do
    get :fetch, to: "write_write#fetch"
    post :not_safe, to: "write_write#not_safe"
    post :safe, to: "write_write#safe"
  end
end
