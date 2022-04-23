class ReportsController < ApplicationController
  def get_todays_report
    report = Order.where(created_at: Date.today.all_day)

    payload = {
      date: Time.current.to_date,
      report: report
    }

    return render json: send_success("✅ Get todays' report", payload)
  end

  def get_report_by_email
    unless is_email_valid(params[:email])
      return render json: send_failed("❌ Email format not valid", nil), status: :bad_request
    end

    report = Order.where(created_at: Date.today.all_day).where(email: params[:email])

    payload = {
      date: Time.current.to_date,
      report: report
    }

    if report.nil?
      return render json: send_failed("❌ No report found for the given email", nil), status: :not_found
    else
      return render json: send_success("✅ Successfully get report by email", payload)
    end
  end

  def get_report_by_price
    unless is_price_valid(params[:total])
      return render json: send_failed("❌ Total price format not valid", nil), status: :bad_request
    end

    report = Order.where("total <= ?", params[:total])

    payload = {
      date: Time.current.to_date,
      report: report
    }

    if report.nil?
      return render json: send_failed("❌ No report found with the given price found", nil), status: :not_found
    else
      return render json: send_success("✅ Successfully get report by price", payload)
    end
  end

  def get_report_by_date
    unless is_date_valid(params[:date])
      return render json: send_failed("❌ Date format not valid", nil), status: :bad_request
    end

    report = Order.where(created_at: params[:date])

    payload = {
      date: Time.current.to_date,
      report: report
    }

    if report.nil?
      return render json: send_failed("❌ No report found with the given date", nil), status: :not_found
    else
      return render json: send_success("✅ Successfully get a report for the date", payload)
    end
  end

  private
  def is_email_valid(email)
    email =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  end

  def is_price_valid(price)
    return true if price =~ /\A[+-]?\d+\Z/
    true if Float(price) rescue false
  end

  def is_date_valid(date)
    date =~ %r{^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$}
  end
end