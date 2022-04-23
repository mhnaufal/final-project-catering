require 'rails_helper'

RSpec.describe ReportsController do
  describe 'GET /reports' do
    it '[controller.report.1] it should return all reports within the day' do
      get :get_todays_report

      parsed_body = JSON.parse(response.body)

      expect(response).to be_successful
      expect(parsed_body["payload"]).to include("date")
      expect(parsed_body["payload"]).to include("report")
    end

    it "[controller.report.2] it should return report by customers' email" do
      get :get_report_by_email, params: { email: "sania@gigih.com" }

      parsed_body = JSON.parse(response.body)

      expect(response).to be_successful
      expect(parsed_body["message"]).to include("✅ Successfully get report by email")
    end

    it '[controller.report.3] is invalid if the email format is incorrect or nil' do
      get :get_report_by_email, params: { email: "sania@gigih" }

      parsed_body = JSON.parse(response.body)

      expect(response).to_not be_successful
      expect(parsed_body["message"]).to include("❌ Email format not valid")
    end

    it '[controller.report.4] it should return report within less than or equal the given price' do
      get :get_report_by_price, params: { total: 10000 }

      parsed_body = JSON.parse(response.body)

      expect(response).to be_successful
      expect(parsed_body["message"]).to include("✅ Successfully get report by price")
    end

    it '[controller.report.5] is invalid if the price is incorrect form or nil' do
      get :get_report_by_price, params: { total: "$100" }

      parsed_body = JSON.parse(response.body)

      expect(response).to_not be_successful
      expect(parsed_body["message"]).to include("❌ Total price format not valid")
    end

    it '[controller.report.6] it should return report based on the given date' do
      get :get_report_by_date, params: { date: "24-04-2022" }

      parsed_body = JSON.parse(response.body)

      expect(response).to be_successful
      expect(parsed_body["message"]).to include("✅ Successfully get a report for the date")
    end

    it '[controller.report.7] is invalid if the date in incorrect form' do
      get :get_report_by_date, params: { date: "2022/01" }

      parsed_body = JSON.parse(response.body)

      expect(response).to have_http_status(:bad_request)
      expect(parsed_body["message"]).to include("❌ Date format not valid")
    end
  end
end