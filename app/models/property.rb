class Property < ApplicationRecord
  has_many :jobs
  belongs_to :landlord, foreign_key: :landlord_id, class_name: "User"
  belongs_to :tenant, foreign_key: :tenant_id, class_name: "User"
end
