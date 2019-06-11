class TenantsTenancy < ApplicationRecord
  belongs_to :tenancy
  belongs_to :tenant, foreign_key: :tenant_id, class_name: "User"
end
