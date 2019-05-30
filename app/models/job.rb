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

  def submitted_at
    created_at.strftime("%e %b %Y")
  end

  def available_dates
    contractor_availabilities.map do |contractor_availability|
      contractor_availability.date_available.strftime("%e %b %Y")
    end
  end

  def self.stage_attributes
    # Class method for all job stage attributes
    {
      1 => {
        stage_name: "Landlord selecting contractors",
        waiting_for: "landlord",
        call_to_action: "Select Contractors",
        just_completed: "Job submitted"
      },
      2 => {
        stage_name: "Contractors adding quotes",
        waiting_for: "contractor",
        call_to_action: "Add a Quote",
        just_completed: "Contractors selected by landlord"
      },
      3 => {
        stage_name: "Landlord reviewing quote",
        waiting_for: "landlord",
        call_to_action: "Review Quotes",
        just_completed: "Contractors provided quotes"
      },
      4 => {
        stage_name: "Contractor adding available dates",
        waiting_for: "contractor",
        call_to_action: "Add Available Times",
        just_completed: "Landlord selected a contractor"
      },
      5 => {
        stage_name: "Tenant selecting a date",
        waiting_for: "tenant",
        call_to_action: "Pick a Date",
        just_completed: "Contractor provided dates"
      },
      6 => {
        stage_name: "Undergoing work",
        waiting_for: "contractor",
        call_to_action: "Finalise Job",
        just_completed: "Tenant selected a suitable date"
      },
      7 => {
        stage_name: "Tenant providing feedback",
        waiting_for: "tenant",
        call_to_action: "Submit Feedback",
        just_completed: "Work completed"
      },
      8 => {
        stage_name: "Landlord completing final review",
        waiting_for: "landlord",
        call_to_action: "Approve and Pay",
        just_completed: "Tenant provided feedback"
      },
      9 => {
        stage_name: nil,
        waiting_for: nil,
        call_to_action: nil,
        just_completed: "Job completed"
      }
    }
  end

  def stage_attributes
    # Instance method for a job's stage attributes
    Job.stage_attributes[current_stage]
  end

  private

  def create_job_stage
    JobStage.create(job: self, stage: current_stage, changed_at: DateTime.now)
  end
end
