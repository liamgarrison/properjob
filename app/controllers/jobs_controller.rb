class JobsController < ApplicationController
  before_action :set_job, only: [:show, :edit, :update]

  def index
    @jobs = Job.all
    @jobs = @jobs.sort_by(&:created_at).reverse
    # @jobs = @jobs.select { |job| belong_to_job?(job) }
    @incompleted_jobs = @jobs.select { |job| belong_to_job?(job) && job.current_stage < 9 }
    @completed_jobs = @jobs.select { |job| belong_to_job?(job) && job.current_stage == 9 }
    @jobs_in_progress = @incompleted_jobs
  end

  def show
    @waiting_for_me = waiting_for_me?(@job)
  end

  def new
    @job = Job.new
    @job.photo_videos.build
    # authorize @job
  end

  def create
    @job = Job.new(category: params[:category_selected], description: params[:description])
    @job.property = Property.first
    @job.current_stage = 1
    if @job.save
      if params[:job][:photo_videos][:photo_video]
        params[:job][:photo_videos][:photo_video].each do |photo_video|
          @job.photo_videos.create(photo_video: photo_video, stage: @job.current_stage)
        end
        redirect_to job_path(@job)
      end
    else
      render :new
    end
  end

  def update
    case @job.current_stage
    when 3
      @quote_accepted = Quote.find(quote_params[:quote_selected])
      @quote_accepted.accepted = true
      @quote_accepted.save
      @quotes_rejected = @job.quotes.reject { |quote| quote.accepted }
      @quotes_rejected.each {|quote| quote.update(accepted: false)}
      @job.update(contractor: @quote_accepted.contractor)
      @job.update(current_stage: 4)
      redirect_to job_path(@job)
    when 4
      date_params[:dates].each do |date|
        ContractorAvailability.create(date_available: date, job: @job, contractor: @job.contractor)
      end
      @job.update(current_stage: 5)
      redirect_to job_path(@job)
    when 5
      @job.update(date: Date.parse(params[:time_selectors]))
      @job.update(current_stage: 6)
      redirect_to job_path(@job)
    when 6
      @job.update(job_params)
      @job.update(current_stage: 7)
      redirect_to job_path(@job)
    when 7
      @job.update(resolved: params[:resolved] == 'true', rating: params[:rating])
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
      @contractor_dates = @job.contractor_availabilities.map { |date| date.date_available.to_s }
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
    quote_params = params.permit(:quote_selected)
    quote_params[:quote_selected] = quote_params[:quote_selected].to_i
    quote_params
  end

  def job_params
    params.require(:job).permit(:category, :description, :resolved, :rating, :photo_videos, :final_price, :invoice)
  end

  def belong_to_job?(job)
    job.contractors.include?(current_user) || current_user == job.contractor || current_user == job.property.tenant || current_user == job.property.landlord
  end

  def waiting_for_me?(job)
    # Find out if the current user is the one we are waiting on.
    if belong_to_job?(job) && @job.stage_attributes[:waiting_for] == current_user.user_type
      @waiting_for_me = true
    else
      @waiting_for_me = false
    end
  end
end
