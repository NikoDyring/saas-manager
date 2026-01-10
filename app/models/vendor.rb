class Vendor < ApplicationRecord
  has_many :subscriptions
  validates :name, presence: true, uniqueness: true
end
