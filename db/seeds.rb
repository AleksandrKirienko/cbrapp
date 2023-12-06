# frozen_string_literal: true

if CurrencyRate.first.nil?
  5.weeks.ago.to_date.upto(Time.zone.today) do |date|
    CbrFetcher.new(date).call.each do |params|
      CurrencyRate.create!(**params)
    end

    print '.'
  end
end
