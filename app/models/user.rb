class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :properties, foreign_key: "landlord_id", class_name: "Property"
  has_many :tenancies, foreign_key: "tenant_id", class_name: "Tenancy"
  has_many :jobs, foreign_key: "contractor_id", class_name: "Job"
  has_many :quotes, foreign_key: "contractor_id", class_name: "Quote"
  has_many :contractor_availabilities, foreign_key: "contractor_id", class_name: "ContractorAvailabilities"
end
