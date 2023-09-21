Rails.application.routes.draw do

  post "/reset", to: "resets#clean_session"

  get "/balance", to: "balances#show"

  post "/event", to: "events#create"
end
