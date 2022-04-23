class OrdersController < ApplicationController
  def index
    @orders = Order.all
    render json: @orders
  end

  def show
    @order = Order.find_by_id(params[:id])

    if @order.nil?
      render json: send_failed("❌ No order with the id = #{params[:id]}", nil), status: :not_found
    else
      render json: send_success("✅ Found order with id = #{params[:id]}", @order)
    end
  end
end
