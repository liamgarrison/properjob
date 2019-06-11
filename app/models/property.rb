class Property < ApplicationRecord
  has_many :jobs
  has_many :tenancies
  belongs_to :landlord, foreign_key: :landlord_id, class_name: "User"
end
