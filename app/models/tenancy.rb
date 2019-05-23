class Tenancy < ApplicationRecord
  belongs_to :tenant, foreign_key: :tenant_id, class_name: "User"
  belongs_to :property

end
