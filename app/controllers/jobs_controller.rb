class JobsController < ApplicationController
  before_action :set_job, only: [:waiting_for, :show]

  def index
    @jobs = Job.all
  end

  def show
    @waiting_for = waiting_for
  end

  def new
    @job = Job.new
    # authorize @job
  end

  def create
    @job = Job.create(job_params)
    @job.property = current_user.property
    if @job.save
      redirect_to job_path(@job)
    else
      render :new
    end
  end

  private

  def set_job
    @job = Job.find(params[:id])
  end

  def job_params
    params.require(:job).permit(:category, :description)
  end

  def waiting_for
    # Find out what stage of the job we are at
    # For that stage, which user type are we waiting for
    waiting_for_stages = {
      1 => "landlord",
      2 => "contractor",
      3 => "landlord",
      4 => "contractor",
      5 => "tenant",
      6 => "contractor",
      7 => "tenant",
      8 => "landlord",
      9 => nil
    }
    return waiting_for_stages[@job.current_stage]
  end

  def waiting_for_me?
    # Find out if the current user is the one we are waiting on.
    if current_user == @job.contractor ||
       current_user == @job.property.tenant ||
       current_user == @job.property.landlord &&
       current_user.user_type == waiting_for
      return true
    else
      return false
    end
  end
end
