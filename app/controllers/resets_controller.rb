class ResetsController < ApplicationController
  def clean_session
    reset_session
    render json: 'OK', status: :ok  
  end
end
