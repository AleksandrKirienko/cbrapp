class CreateCurrencyRates < ActiveRecord::Migration[7.1]
  def change
    create_table :currency_rates do |t|
      t.integer :currency
      t.float :rate
      t.date :fetched_at

      t.timestamps
    end

    add_index :currency_rates, :fetched_at
  end
end
