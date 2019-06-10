class Api::V1::JobsController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User
  def index
    @jobs = Job.all
  end

  def show
    @job = Job.find(params[:id])
  end

  def update
    @job = Job.find(params[:id])
    if @job.update(job_params)
      render :show
    else
      render_error
    end
  end

  def create
    @job = Job.new(job_params)
    @job.property = Property.first
    @job.current_stage = 1
    if @job.save
      render :show, status: :created
    else
      render_error
    end
  end

  def job_params
    params.require(:job).permit(:category, :description)
  end

  def render_error
    render json: { errors: @job.errors.full_messages },
      status: :unprocessable_entity
  end
end