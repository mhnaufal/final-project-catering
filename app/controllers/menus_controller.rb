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
    found_menu = Menu.find_by(name: params[:name])

    if not found_menu.nil?
      return render json: send_failed("Menu with that name already exists"), status: :conflict
    end

    menu = Menu.new(menu_params)

    if menu.valid?
      menu.save
      return render json: send_success("Successfully create a Menu", menu)
    else
      render json: send_failed("Error while creating a menu"), status: :bad_request
    end
  end

  def destroy
    @menu = Menu.find_by_id(params[:id])

    if @menu.nil?
      return render json: send_failed("Error while deleting a menu. Menu not found", nil), status: :not_found
    else
      return render json: send_success("Successfully delete a menu", nil)
    end
  end
  
  private
  def menu_params
    params.permit(:name, :description, :price, :categories)
  end
end
