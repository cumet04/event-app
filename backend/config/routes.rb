Rails.application.routes.draw do
  scope :api, format: false do
    namespace :users, controller: :users, module: nil do
      put "", action: :create
      post "session", action: :login
      delete "session", action: :logout
      get "current", action: :current
    end
  end
end
