class MenusController < ApplicationController
  def index
    render json: Menu.all
  end

  def show
    @menu = Menu.find(params[:id])
    render json: @menu
  end
end
