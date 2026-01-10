class CreateVendors < ActiveRecord::Migration[8.1]
  def change
    create_table :vendors do |t|
      t.string :name
      t.string :category
      t.string :logo_url

      t.timestamps
    end
  end
end
