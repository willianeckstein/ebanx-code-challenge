class EventsController < ApplicationController
  def create 
    if session[create_params[:destination]].blank?
      session[create_params[:destination]] = create_params[:amount]
    else
      session[create_params[:destination]] = session[create_params[:destination]] + create_params[:amount]
    end

    response = {
      "destination" => {
        "id" => create_params[:destination],
        "balance" => session[create_params[:destination]]
      }
    }

    render json: response, status: :created
  end

  private

  def create_params
    params.require(:event).permit(:type, :destination, :amount) 
  end
end
