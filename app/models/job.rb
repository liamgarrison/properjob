class Job < ApplicationRecord
  belongs_to :property
  belongs_to :contractor, foreign_key: :contractor_id, class_name: "User", optional: true
  has_many :job_stages
  has_many :contractor_availabilities
  has_many :quotes
  has_many :photo_videos
  has_many :contractors, through: :quotes, foreign_key: :contractor_id, class_name: "User"
  mount_uploader :invoice, PhotoUploader
  after_save :create_job_stage, if: :saved_change_to_current_stage?

  def index
    @user = User.find(params[:id])
  end

  def stage_changed_at(stage)
    job_stages.find_by_stage(stage).changed_at.strftime("%e %b %Y %H:%M")
  end

  def available_dates
    contractor_availabilities.map do |contractor_availability|
      contractor_availability.date_available.strftime("%e %b %Y")
    end
  end

  private

  def create_job_stage
    JobStage.create(job: self, stage: current_stage, changed_at: DateTime.now)
  end
end
