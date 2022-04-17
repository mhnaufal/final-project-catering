class MenusController < ApplicationController
  def index
    render json: Menu.all
  end

  def show
    @menu = Menu.find_by_id(params[:id])
    if @menu.nil?
      render json: { message: "No Menu with that id" }, status: :not_found
    else
      render json: @menu
    end
  end
  
end
