class AddCountryCode < ActiveRecord::Migration[6.1]
  def change
    add_column :traceips, :code, :string
  end
end
