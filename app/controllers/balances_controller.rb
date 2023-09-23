class BalancesController < ApplicationController
  def show
    if session[params[:account_id]].blank?
      render json: 0, status: :not_found 
    else
      render json: session[params[:account_id]], status: :ok
    end    
  end
end
