# frozen_string_literal: true

require 'open-uri'
require 'nokogiri'

class CbrFetcher
  REQUIRED_CURRENCIES = %w(usd eur cny)

  attr_reader :fetched_at

  def initialize(fetched_at)
    @fetched_at = fetched_at
  end

  def call
    api_response(fetched_at).xpath('//Valute').each_with_object([]) do |valute, result|
      currency = valute.at('CharCode').text.downcase

      next unless REQUIRED_CURRENCIES.include?(currency)
      
      rate = valute.at('VunitRate').text.gsub(',', '.').to_f.round(2)

      result << {currency: currency, rate: rate, fetched_at: fetched_at}
    end
  end

  private

  def api_response(fetched_at)
    Nokogiri::XML(URI.open("https://www.cbr.ru/scripts/XML_daily.asp?date_req=#{fetched_at.strftime('%d/%m/%Y')}"))
  end
end
