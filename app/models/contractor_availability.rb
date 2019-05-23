class ContractorAvailability < ApplicationRecord
  belongs_to :job
  belongs_to :contractor, foreign_key: :contractor_id, class_name: "User"
end
