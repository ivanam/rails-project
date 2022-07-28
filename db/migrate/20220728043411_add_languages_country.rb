class AddLanguagesCountry < ActiveRecord::Migration[6.1]
  def change
    add_column :countries, :languages, :jsonb, default: {}
  end
end
