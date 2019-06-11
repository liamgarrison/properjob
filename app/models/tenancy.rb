class Tenancy < ApplicationRecord
  belongs_to :property
  has_many :tenants_tenancies, foreign_key: "tenant_id", class_name: "TenantsTenancy"
  has_many :tenants, through: :tenants_tenancies
  def current
    end_date >= Date.today && start_date <= Date.today
  end
end
