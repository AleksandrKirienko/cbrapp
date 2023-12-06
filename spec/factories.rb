# frozen_string_literal: true

FactoryBot.define do
  factory(:currency_rate) do
    rate { 9.1 }
    currency { 0 }
    fetched_at { Time.zone.today }
  end
end
