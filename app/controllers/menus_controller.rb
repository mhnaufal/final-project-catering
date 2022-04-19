class MenusController < ApplicationController
  def index
    @menus = Menu.all
    render json: {
      status: 'SUCCESS',
      url: request.host || '0.0.0.0',
      message: 'All available menus',
      payload: @menus
    }
  end

  def show
    @menu = Menu.find_by_id(params[:id])

    if @menu.nil?
      render json: { message: "No Menu with the id = #{params[:id]}" }, status: :not_found
    else
      render json: {
        status: 'SUCCESS',
        url: request.host || '0.0.0.0',
        message: "Menu with id = #{params[:id]}",
        payload: @menu
      }
    end
  end
  
end
