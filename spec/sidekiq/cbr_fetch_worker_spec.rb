# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CbrFetchWorker, type: :worker do
  describe '#perform' do
    let(:cbr_fetcher) { instance_double(CbrFetcher) }
    let(:date_today) { Time.zone.today }

    before { allow(CbrFetcher).to receive(:new).with(date_today).and_return(cbr_fetcher) }

    context 'when currency rates are fetched successfully' do
      let(:params) { { currency: 'usd', rate: 1.0 } }

      before do
        allow(cbr_fetcher).to receive(:call).and_return([params])
      end

      it 'creates CurrencyRate records' do
        expect(CurrencyRate).to receive(:create!).with(params)

        subject.perform
      end
    end

    context 'when ActiveRecord::RecordInvalid is raised' do
      let(:error_message) { 'Validation failed' }

      before do
        currency_rate = CurrencyRate.new
        currency_rate.errors.add(:base, error_message)
        allow(cbr_fetcher).to receive(:call).and_raise(ActiveRecord::RecordInvalid.new(currency_rate))
      end

      it 'logs an error message' do
        expect(Rails.logger).to receive(:error)
          .with("Todays rate was already fetched and stored: Validation failed: #{error_message}")

        subject.perform
      end
    end
  end
end
