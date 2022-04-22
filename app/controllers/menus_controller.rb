class MenusController < ApplicationController
  def index
    @menus = Menu.all
    return render json: send_success("All available menus", @menus)
  end

  def show
    @menu = Menu.find_by_id(params[:id])

    if @menu.nil?
      render json: { message: "No Menu with the id = #{params[:id]}" }, status: :not_found
    else
      return render json: send_success("Menu with id = #{params[:id]}", @menu)
    end
  end

  def create
    menu = Menu.new(menu_params)
    menu.save
    return render json: send_success("Successfully create a Menu", menu)
  end
  
  private
  def menu_params
    params.permit(:name, :description, :price, :categories)
  end
end
