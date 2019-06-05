class Job < ApplicationRecord
  belongs_to :property
  belongs_to :contractor, foreign_key: :contractor_id, class_name: "User", optional: true
  has_many :job_stages
  has_many :messages
  has_many :contractor_availabilities
  has_many :quotes
  has_many :photo_videos
  has_many :contractors, through: :quotes, foreign_key: :contractor_id, class_name: "User"
  mount_uploader :invoice, PhotoUploader
  after_save :create_job_stage, if: :saved_change_to_current_stage?
  validates :description, presence: true
  validates :category, presence: true

  def index
    @user = User.find(params[:id])
  end

  def stage_changed_at(stage)
    job_stages.find_by_stage(stage).changed_at.strftime("%e %b %Y %H:%M")
  end

  def date
    super.strftime("%e %b %Y")
  end

  def available_dates
    contractor_availabilities.map do |contractor_availability|
      contractor_availability.date_available.strftime("%e %b %Y")
    end
  end

  def self.stage_attributes
    # Class method for all job stage attributes
    {
      0 => {
        stage_name_past: "Tenant submitted job",
        stage_name_present: "Tenant submitting job",
        stage_name_future: "Tenant to submit job",
        waiting_for: "tenant",
        call_to_action: "Submit Job"
      },
      1 => {
        stage_name_past: "Landlord found contractors",
        stage_name_present: "Landlord finding contractors",
        stage_name_future: "Landlord to find contractors",
        waiting_for: "landlord",
        call_to_action: "Find Contractors"
      },
      2 => {
        stage_name_past: "Contractors added quotes",
        stage_name_present: "Contractors adding quotes",
        stage_name_future: "Contractors to add quotes",
        waiting_for: "contractor",
        call_to_action: "Add a Quote"
      },
      3 => {
        stage_name_past: "Landlord selected a contractor",
        stage_name_present: "Landlord selecting a contractor",
        stage_name_future: "Landlord to select a contractor",
        waiting_for: "landlord",
        call_to_action: "Review Quotes"
      },
      4 => {
        stage_name_past: "Contractor provided dates",
        stage_name_present: "Contractor providing dates",
        stage_name_future: "Contractor to provide dates",
        waiting_for: "contractor",
        call_to_action: "Add Available Dates"
      },
      5 => {
        stage_name_past: "Tenant picked a date",
        stage_name_present: "Tenant picking a date",
        stage_name_future: "Tenant to pick a date",
        waiting_for: "tenant",
        call_to_action: "Pick a Date"
      },
      6 => {
        stage_name_past: "Contractor completed job",
        stage_name_present: "Contractor completing job",
        stage_name_future: "Contractor to complete job",
        waiting_for: "contractor",
        call_to_action: "Mark Job As Done"
      },
      7 => {
        stage_name_past: "Tenant added feedback",
        stage_name_present: "Tenant adding feedback",
        stage_name_future: "Tenant to add feedback",
        waiting_for: "tenant",
        call_to_action: "Add Feedback"
      },
      8 => {
        stage_name_past: "Landlord reviewed job",
        stage_name_present: "Landlord reviewing job",
        stage_name_future: "Landlord to review job",
        waiting_for: "landlord",
        call_to_action: "Approve and Pay"
      },
      9 => {
        stage_name_past: "Job completed",
        stage_name_present: "Job completed",
        stage_name_future: "Job completed",
        waiting_for: nil,
        call_to_action: nil      }
    }
  end

  def stage_attributes
    # Instance method for a job's stage attributes
    Job.stage_attributes[current_stage]
  end

  def accepted_quote
    quotes.find_by_accepted(true)
  end

  def contractors_already_submitted_quote
    quotes.select { |quote| quote.submitted }.map(&:contractor)
  end

  private

  def create_job_stage
    JobStage.create(job: self, stage: current_stage, changed_at: DateTime.now)
  end
end
