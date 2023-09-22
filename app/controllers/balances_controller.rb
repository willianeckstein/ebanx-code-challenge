class BalancesController < ApplicationController
  def show
    account = session.dig("accounts", params[:account_id]) unless !session[:accounts]

    if !account
      render json: 0, status: :not_found 
    else
      render json: account
    end
    
  end
end
