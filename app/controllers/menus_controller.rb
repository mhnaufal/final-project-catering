class MenusController < ApplicationController
  def index
    @menus = Menu.all
    render json: @menus
  end

  def show
    @menu = Menu.find_by_id(params[:id])
    if @menu.nil?
      render json: { message: "No Menu with the id = #{params[:id]}" }, status: :not_found
    else
      render json: @menu
    end
  end
  
end
