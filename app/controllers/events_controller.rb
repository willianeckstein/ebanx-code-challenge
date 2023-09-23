class EventsController < ApplicationController
  def create 
    case create_params[:type]
    when "deposit"
      deposit_handler(create_params[:destination], create_params[:amount])
      render json: deposit_response(create_params[:destination]), status: :created
    when "withdraw"
      if session[create_params[:origin]].blank?
        render json: 0, status: :not_found
      else
        withdraw_handler(create_params[:origin], create_params[:amount])    
        render json: withdraw_response(create_params[:origin]), status: :created
      end
    when "transfer"
      if session[create_params[:origin]].blank?
        render json: 0, status: :not_found
      else
        transfer_handler(create_params[:origin], create_params[:destination], create_params[:amount])    
        render json: transfer_response(create_params[:origin], create_params[:destination]), status: :created
      end
    end
 
  end

  private

  def create_params
    params.require(:event).permit(:type, :destination, :amount, :origin) 
  end

  def deposit_handler(destination, amount) 
    if session[destination].blank?
      session[destination] = amount
    else
      session[destination] = session[destination] + amount
    end
  end

  def withdraw_handler(origin, amount) 
    session[origin] = session[origin] - amount
  end

  def transfer_handler(origin, destination, amount)
    withdraw_handler(origin, amount)
    deposit_handler(destination, amount)
  end

  def deposit_response(destination)
    response = {
      "destination" => {
        "id" => destination,
        "balance" => session[destination]
      }
    }

    response
  end

  def withdraw_response(origin)
    response = {
      "origin" => {
        "id" => origin,
        "balance" => session[origin]
      }
    }

    response
  end

  def transfer_response(origin, destination)
    response = {
      "origin" => {
        "id" => origin,
        "balance" => session[origin]
      },
      "destination" => {
        "id" => destination,
        "balance" => session[destination]
      }
    }

    response
  end
end
