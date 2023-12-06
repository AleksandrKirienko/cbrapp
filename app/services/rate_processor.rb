# frozen_string_literal: true

class RateProcessor
  def get_summary_deltas(weeks_count)
    CurrencyRate.currencies.keys.each_with_object({}) do |currency, result|
      result[currency] = get_weekly_deltas(currency, weeks_count)
    end
  end

  private

  def get_weekly_deltas(currency, weeks_count)
    last_weeks_groups(currency, weeks_count).first(weeks_count).map do |week|
      week_days = week.second

      monday_value = week_days.first.rate
      sunday_value = week_days.last.rate

      percentage_off(monday_value, sunday_value)
    end
  end

  def last_weeks_groups(currency, weeks_count)
    initial_date = weeks_count.weeks.ago.beginning_of_week

    CurrencyRate.where(currency: currency)
                .where("fetched_at >= ?", initial_date)
                .order(fetched_at: :asc)
                .group_by{ |rate| rate.fetched_at.beginning_of_week }
  end

  def percentage_off(monday_value, sunday_value)
    (Float(monday_value - sunday_value) / monday_value * 100).ceil
  end
end