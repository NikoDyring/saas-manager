class Subscription < ApplicationRecord
  belongs_to :organization
  belongs_to :vendor

  validates :amount_cents, numericality: { greater_than_or_equal_to: 0 }
  
  def annual_cost
    billing_cycle == 'monthly' ? amount_cents * 12 : amount_cents
  end
end