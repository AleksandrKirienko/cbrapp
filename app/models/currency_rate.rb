# frozen_string_literal: true

class CurrencyRate < ApplicationRecord
  enum currency: { usd: 0, eur: 1, cny: 2 }

  validates :currency, :rate, :fetched_at, presence: true
  validates :fetched_at, uniqueness: { scope: :currency }
end
