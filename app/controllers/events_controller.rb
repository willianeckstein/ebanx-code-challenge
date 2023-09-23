class EventsController < ApplicationController
  def create 
    case create_params[:type]
    when "deposit"
      if session[create_params[:destination]].blank?
        session[create_params[:destination]] = create_params[:amount]

        response = {
          "destination" => {
            "id" => create_params[:destination],
            "balance" => session[create_params[:destination]]
          }
        }
    
        render json: response, status: :created
      else
        session[create_params[:destination]] = session[create_params[:destination]] + create_params[:amount]

        response = {
          "destination" => {
            "id" => create_params[:destination],
            "balance" => session[create_params[:destination]]
          }
        }
    
        render json: response, status: :created
      end
    when "withdraw"
      if session[create_params[:destination]].blank?
        render json: 0, status: :not_found
      else
        session[create_params[:destination]] = session[create_params[:destination]] - create_params[:amount]

        response = {
          "origin" => {
            "id" => create_params[:destination],
            "balance" => session[create_params[:destination]]
          }
        }
    
        render json: response, status: :created
      end
    when "transfer"
      if session[create_params[:origin]].blank?
        render json: 0, status: :not_found
      else
        session[create_params[:origin]] = session[create_params[:origin]] - create_params[:amount]

        if session[create_params[:destination]].blank?
          session[create_params[:destination]] = create_params[:amount]
        else
          session[create_params[:destination]] = session[create_params[:destination]] + create_params[:amount]
        end

        response = {
          "origin" => {
            "id" => create_params[:origin],
            "balance" => session[create_params[:origin]]
          },
          "destination" => {
            "id" => create_params[:destination],
            "balance" => session[create_params[:destination]]
          }
        }
    
        render json: response, status: :created
      end
    end
 
  end

  private

  def create_params
    params.require(:event).permit(:type, :destination, :amount, :origin) 
  end
end
