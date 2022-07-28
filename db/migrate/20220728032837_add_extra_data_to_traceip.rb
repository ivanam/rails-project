class AddExtraDataToTraceip < ActiveRecord::Migration[6.1]
  def change
    add_column :traceips, :extra_data, :jsonb, default: {}
  end
end
