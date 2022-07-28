class AddCurrencyCountry < ActiveRecord::Migration[6.1]
  def change
    add_column :countries, :currency_id, :integer
    add_index :countries, :currency_id
  end
end
