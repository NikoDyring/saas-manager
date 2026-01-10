class CreateSubscriptions < ActiveRecord::Migration[8.1]
  def change
    create_table :subscriptions do |t|
      t.references :organization, null: false, foreign_key: true
      t.references :vendor, null: false, foreign_key: true
      t.string :billing_cycle, default: 'monthly'
      t.integer :amount_cents, default: 0, null: false
      t.string :currency, default: 'DKK'
      t.date :renewal_date
      t.string :status, default: 'active'

      t.timestamps
    end
  end
end
