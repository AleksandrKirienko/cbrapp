# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RateProcessor do
  subject { described_class.new }

  let(:first_date) { Date.new(2023, 9, 20) }
  let(:last_date) { Date.new(2023, 9, 27) }

  let(:expected_summary_deltas) { {"usd"=>[1], "eur"=>[1], "cny"=>[1]} }

  let(:expected_chart_data) do
    [["x", "2023-09-20", "2023-09-21", "2023-09-22", "2023-09-23", "2023-09-24", "2023-09-25", "2023-09-26", "2023-09-27"],
     ["USD", 96.22, 96.62, 96.08, 96.04, 96.04, 96.04, 96.15, 96.24],
     ["EUR", 102.92, 103.37, 102.36, 102.25, 102.25, 102.25, 102.25, 101.99],
     ["CNY", 13.17, 13.21, 13.13, 13.14, 13.14, 13.14, 13.14, 13.15]]
  end

  before do
    Timecop.freeze(last_date)

    first_date.upto(last_date) do |date|
      CbrFetcher.new(date).call.each do |params|
        create(:currency_rate, **params)
      end
    end
  end

  after { Timecop.return }  

  describe "#get_summary_deltas" do 
    it "returns hash of rate dynamic" do
      expect(subject.get_summary_deltas(1)).to eq(expected_summary_deltas)
    end
  end

  describe "#get_chart_data" do 
    it "returns array for chart building" do
      expect(subject.get_chart_data(first_date)).to eq(expected_chart_data)
    end
  end
end
