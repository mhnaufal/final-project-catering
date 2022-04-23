class HomeController < ActionController::Base
  def index
    render json: {
      status: 'SUCCESS',
      url: request.host || '0.0.0.0',
      message: 'Welcome to GIGIH Family Catering🦐 ',
      payload: nil
    }
  end
end
