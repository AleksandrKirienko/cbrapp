if CurrencyRate.first.nil?
  5.weeks.ago.to_date.upto(Date.today) do |date|
    CbrFetcher.new(date).call.each do |params|
      CurrencyRate.create!(**params)
    end

    print '.'
  end
end
