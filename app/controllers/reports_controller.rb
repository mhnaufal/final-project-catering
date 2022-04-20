class ReportsController < ApplicationController
  def get_todays_report
    report = Order.where(created_at: Date.today.all_day)
    payload = {
      date: Time.current.to_date,
      report: report
    }

    render json: send_success("Get todays' report", payload)
  end
end