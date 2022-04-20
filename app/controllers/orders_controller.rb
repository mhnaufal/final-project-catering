class OrdersController < ApplicationController
  def index
    @orders = Order.all
    render json: @orders
  end

  def show
    @order = Order.find_by_id(params[:id])
  
    if @order.nil?
      render json: { 
        status: "NOT_FOUND",
        url: request.host || '0.0.0.0',
        message: "No order with the id = #{params[:id]}",
        payload: @order
      }, status: :not_found
    else
      render json: { 
        status: "SUCCESS",
        url: request.host || '0.0.0.0',
        message: "Found order with id = #{params[:id]}",
        payload: @order
      }
    end
  end
end
