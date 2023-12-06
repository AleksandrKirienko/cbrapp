# frozen_string_literal: true

class CbrFetchWorker
  include Sidekiq::Job
  include Sidekiq::Worker

  def perform
    CbrFetcher.new(Time.zone.today).call.each do |params|
      CurrencyRate.create!(**params)
    end
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error("Todays rate was already fetched and stored: #{e.message}")
  end
end
