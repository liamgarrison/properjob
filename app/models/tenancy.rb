class Tenancy < ApplicationRecord
  belongs_to :tenant, foreign_key: :tenant_id, class_name: "User"
  belongs_to :rented_property, foreign_key: :property_id, class_name: "Property"

end
