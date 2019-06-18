class Property < ApplicationRecord
  has_many :jobs
  has_many :tenancies
  has_many :tenants_tenancies, through: :tenancies
  has_many :tenants, -> { distinct }, through: :tenants_tenancies, foreign_key: :tenant_id, class_name: "User"
  belongs_to :landlord, foreign_key: :landlord_id, class_name: "User"
end
