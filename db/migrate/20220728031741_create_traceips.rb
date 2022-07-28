class CreateTraceips < ActiveRecord::Migration[6.1]
  def change
    create_table :traceips do |t|
      t.string :ip
      t.integer :country_id
      t.bigint :distance

      t.timestamps
    end
  end
end
