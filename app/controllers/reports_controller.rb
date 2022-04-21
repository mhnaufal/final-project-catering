class ReportsController < ApplicationController
  def get_todays_report
    report = Order.where(created_at: Date.today.all_day)

    payload = {
      date: Time.current.to_date,
      report: report
    }

    render json: send_success("Get todays' report", payload)
  end

  def get_report_by_email
    unless is_email_valid(params[:email])
      return render json: send_failed("Email format not valid", nil), status: :bad_request
    end

    report = Order.where(created_at: Date.today.all_day).where(email: params[:email])

    payload = {
      date: Time.current.to_date,
      report: report
    }

    if report.nil?
      return render json: send_failed("No report found", nil), status: :not_found
    else
      return render json: send_success("Get todays' report", payload)
    end
  end

  def get_report_by_price
    report = Order.where("total <= ?", params[:total])

    return render json: send_success("Get report by price", report)
  end

  private
  def is_email_valid(email)
    email =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  end
end