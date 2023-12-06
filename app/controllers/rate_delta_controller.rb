class RateDeltaController < ApplicationController
  DEFAULT_WEEK_COUNT = 4

  def index
    @deltas = RateProcessor.new.get_summary_deltas(DEFAULT_WEEK_COUNT)
  end
end
