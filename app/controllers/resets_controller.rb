class ResetsController < ApplicationController
  def clean_session
    reset_session
    render status: :ok  
  end
end
