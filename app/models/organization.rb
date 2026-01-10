class Organization < ApplicationRecord
  has_many :users
  has_many :subscriptions
  has_many :vendors, through: :subscriptions
end
