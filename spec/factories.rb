FactoryBot.define do
  factory(:currency_rate) do
    rate { 9.1 }
    currency { 0 }
    fetched_at { Date.today }
  end
end
