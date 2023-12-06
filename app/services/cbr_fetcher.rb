# frozen_string_literal: true

require 'open-uri'
require 'nokogiri'

class CbrFetcher
  attr_reader :fetched_at

  def initialize(fetched_at)
    @fetched_at = fetched_at
  end

  def call
    api_response.xpath('//Valute').each_with_object([]) do |valute, result|
      currency = valute.at('CharCode').text.downcase

      next unless CurrencyRate.currencies.keys.include?(currency)

      rate = valute.at('VunitRate').text.gsub(',', '.').to_f.round(2)

      result << { currency:, rate:, fetched_at: }
    end
  end

  private

  def api_response
    Nokogiri::XML(URI.open("https://www.cbr.ru/scripts/XML_daily.asp?date_req=#{fetched_at.strftime('%d/%m/%Y')}"))
  end
end
