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
    end
  end


  private

  def set_job
    @job = Job.find(params[:id])
  end

  def quote_params
    quote_params = params.permit(:quote_id)
    quote_params[:quote_id] = quote_params[:quote_id].to_i
    quote_params
  end

  def job_params
    params.require(:job).permit(:category, :description)
  end

  def set_current_stage_attributes
    # Find out what stage of the job we are at
    # For that stage, which user type are we waiting for
    stage_attributes = {
      1 => {
        stage_name: "Landlord selecting contractors",
        waiting_for: "landlord",
        call_to_action: "Select Contractors"
      },
      2 => {
        stage_name: "Contractors adding quotes",
        waiting_for: "contractor",
        call_to_action: "Add a Quote"
      },
      3 => {
        stage_name: "Landlord reviewing quote",
        waiting_for: "landlord",
        call_to_action: "Review Quotes"
      },
      4 => {
        stage_name: "Contractor adding available dates/times",
        waiting_for: "contractor",
        call_to_action: "Add Available Times"
      },
      5 => {
        stage_name: "Tenant selecting a date/time",
        waiting_for: "tenant",
        call_to_action: "Pick a Time"
      },
      6 => {
        stage_name: "Undergoing work",
        waiting_for: "contractor",
        call_to_action: "Finalise Job"
      },
      7 => {
        stage_name: "Tenant providing feedback",
        waiting_for: "tenant",
        call_to_action: "Submit Feedback"
      },
      8 => {
        stage_name: "Landlord completing final review",
        waiting_for: "landlord",
        call_to_action: "Approve and Pay"
      },
      9 => {
        stage_name: "Job completed",
        waiting_for: nil,
        call_to_action: nil
      }
    }
    @current_stage_attributes = stage_attributes[@job.current_stage]
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
