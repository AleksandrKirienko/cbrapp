# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CbrFetcher do
  subject { described_class.new(date) }

  let(:date) { Date.new(2023, 9, 20) }

  let(:expected_rates) do
    [{currency: "usd", rate: 96.22, fetched_at: date},
     {currency: "eur", rate: 102.92, fetched_at: date},
     {currency: "cny", rate: 13.17, fetched_at: date}]
  end

  describe "#call" do 
    it "returns array of rates" do
      expect(subject.call).to eq(expected_rates)
    end
  end
end
