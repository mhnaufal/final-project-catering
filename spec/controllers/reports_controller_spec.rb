require 'rails_helper'

RSpec.describe ReportsController do
  describe 'GET /reports' do
    it '[controller.report.1] it should return all reports within the day' do
      reports = Struct.new(:date, :report).new Time.current.to_date, []

      get :get_todays_report

      parsed_body = JSON.parse(response.body)

      expect(response).to be_successful
      expect(parsed_body["payload"]).to include("date")
      expect(parsed_body["payload"]).to include("report")
    end
  end
end