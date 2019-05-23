class Quote < ApplicationRecord
  belongs_to :contractor, foreign_key: :contractor_id, class_name: "User"
  belongs_to :job
end
