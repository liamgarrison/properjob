class Job < ApplicationRecord
  belongs_to :property
  belongs_to :contractor, foreign_key: :contractor_id, class_name: "User"
  has_many :job_stages
  has_many :contractor_availabilities
  has_many :quotes
end
