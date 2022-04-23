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

  def create
    order = Order.new(order_params)

    if order.valid?
      order.save
      return render json: send_success("✅ Successfully create a new order", order)
    else
      render json: send_failed("❌ Error while creating an order"), status: :bad_request
    end
  end

  def change_status
    found_order = Order.find_by_id(params[:id])

    if found_order.nil?
      return render json: send_failed("❌ No order with the id exists"), status: :not_found
    end

    found_order.update_attribute(:status, params[:new_status])

    if found_order.valid?
      return render json: send_success("✅ Successfully update an Order", found_order)
    else
      render json: send_failed("❌ Error while updating an order"), status: :bad_request
    end
  end

  private
  def order_params
    params.permit(:email, :status, :total)
  end
end
