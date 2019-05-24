class JobsController < ApplicationController
  before_action :set_job, only: [ :show ]

  def index
    @jobs = Job.all
  end

  def show
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
end
