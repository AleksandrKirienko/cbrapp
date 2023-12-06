# frozen_string_literal: true

class RateProcessor
  def get_summary_deltas(weeks_count)
    CurrencyRate.currencies.keys.each_with_object({}) do |currency, result|
      result[currency] = get_weekly_deltas(currency, weeks_count)
    end
  end

  def get_chart_data(initial_date = 1.month.ago.to_date)
    date_array = (initial_date..Date.today).each_with_object(["x"]) do |date, date_array|
      date_array << date.strftime("%Y-%m-%d")
    end

    CurrencyRate.currencies.keys.each_with_object([date_array]) do |currency, chart_data|
      chart_data << [currency.upcase, *last_weeks_groups(currency, initial_date).pluck(:rate)]
    end
  end

  private

  def get_weekly_deltas(currency, weeks_count)
    initial_date = weeks_count.weeks.ago.beginning_of_week
    week_groups = last_weeks_groups(currency, initial_date).group_by { |rate| rate.fetched_at.beginning_of_week }

    week_groups.first(weeks_count).map do |week|
      week_days = week.second

      monday_value = week_days.first.rate
      sunday_value = week_days.last.rate

      percentage_off(monday_value, sunday_value)
    end
  end

  def last_weeks_groups(currency, initial_date)
    CurrencyRate.where(currency: currency).where("fetched_at >= ?", initial_date)
                .order(fetched_at: :asc)
  end

  def percentage_off(monday_value, sunday_value)
    (Float(monday_value - sunday_value) / monday_value * 100).ceil
  end
end
