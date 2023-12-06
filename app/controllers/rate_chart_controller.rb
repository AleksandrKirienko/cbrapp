class RateChartController < ApplicationController
  def index
    @chart_data = RateProcessor.new.get_chart_data.to_json
  end
end
