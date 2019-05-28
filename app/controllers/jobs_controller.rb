class JobsController < ApplicationController
  before_action :set_job, only: [:show, :edit, :update]
  before_action :set_current_stage_attributes, only: [:show, :edit]
  before_action :waiting_for_me?, only: [:show]

  def index
    @jobs = Job.all
  end

  def show
    @waiting_for_me = waiting_for_me?
  end

  def new
    @job = Job.new
    # authorize @job
  end

  def create
    @job = Job.create(job_params)
    @job.property = Property.first
    @job.current_stage = 1
    if @job.save
      redirect_to job_path(@job)
    else
      render :new
    end
  end

  def update
    case @job.current_stage
    when 3
      @quote_accepted = Quote.find(quote_params[:quote_id])
      @quote_accepted.accepted = true
      @quote_accepted.save
      @quotes_rejected = @job.quotes.reject { |quote| quote.accepted }
      @quotes_rejected.each {|quote| quote.update(accepted: false)}
      @job.update(contractor: @quote_accepted.contractor, final_price: @quote_accepted.price)
      @job.update(current_stage: 4)
      redirect_to job_path(@job)
    when 4
      date_params[:dates].each do |date|
        ContractorAvailability.create(date_available: date, job: @job, contractor: @job.contractor)
      end
      @job.update(current_stage: 5)
      redirect_to job_path(@job)
    when 5
      @job.update(date: tenant_date_params[:date])
      @job.update(current_stage: 6)
      redirect_to job_path(@job)
    when 6
      @job.update(invoice_params)
      @job.update(current_stage: 7)
      redirect_to job_path(@job)
    when 7
      @job.update(job_params)
      @job.update(current_stage: 8)
      redirect_to job_path(@job)
    end
  end

  def edit
    case @job.current_stage
    when 1
      @contractors = User.where(contractor_type: @job.category)
      render "jobs/action_forms/stage_one"
    when 2
      @quote = Quote.where(contractor: current_user, job: @job).first
      render "jobs/action_forms/stage_two"
    when 3
      @quotes = Quote.where(job: @job)
      render "jobs/action_forms/stage_three"
    when 4
      render "jobs/action_forms/stage_four"
    when 5
      render "jobs/action_forms/stage_five"
    when 6
      render "jobs/action_forms/stage_six"
    when 7
      render "jobs/action_forms/stage_seven"
    when 8
      render "jobs/action_forms/stage_eight"
    end
  end


  private

  def set_job
    @job = Job.find(params[:id])
  end

  def date_params
    date_params = params.permit(dates: [])
    date_params[:dates].map do |date|
      Date.parse(date)
    end
    date_params
  end

  def tenant_date_params
    tenant_date_params = params.permit(:date)
  end

  def quote_params
    quote_params = params.permit(:quote_id)
    quote_params[:quote_id] = quote_params[:quote_id].to_i
    quote_params
  end

  def job_params
    params.require(:job).permit(:category, :description, :resolved, :rating)
  end

  def invoice_params
    params.require(:job).permit(:invoice_url)
  end

  def set_current_stage_attributes
    # Find out what stage of the job we are at
    # For that stage, which user type are we waiting for
    @stage_attributes = {
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
    @current_stage_attributes = @stage_attributes[@job.current_stage]
  end

  def belong_to_job?
    @job.contractors.include?(current_user) || current_user == @job.contractor || current_user == @job.property.tenant || current_user == @job.property.landlord
  end

  def waiting_for_me?
    # Find out if the current user is the one we are waiting on.
    if belong_to_job? && @current_stage_attributes[:waiting_for] == current_user.user_type
      @waiting_for_me = true
    else
      @waiting_for_me = false
    end
  end

end
