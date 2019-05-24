class Job < ApplicationRecord
  belongs_to :property
  belongs_to :contractor, foreign_key: :contractor_id, class_name: "User", optional: true
  has_many :job_stages
  has_many :contractor_availabilities
  has_many :quotes
  has_many :photo_videos
  has_many :contractors, through: :quotes, foreign_key: :contractor_id, class_name: "User"
  mount_uploader :invoice_url, PhotoUploader

  def index
    @user= User.find(params[:id])
  end
end
