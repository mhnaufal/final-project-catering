class ApplicationController < ActionController::Base
  helper_method :send_success
  helper_method :send_failed

  def send_success(message, payload)
    {
      status: "SUCCESS",
      url: request.host,
      message: message,
      payload: payload
    }
  end

  def send_failed(message, payload)
    {
      status: "FAILED",
      url: request.host,
      message: message,
      payload: payload
    }
  end
end
