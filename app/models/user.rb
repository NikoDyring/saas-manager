class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable,
         :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self


  belongs_to :organization

  before_validation :set_default_role, on: :create

  private

  def set_default_role
    self.role ||= "admin"
  end
end
