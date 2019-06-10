class Api::V1::JobsController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User, except: [ :index, :show ]
  def index
    @jobs = policy_scope(Job)
  end

  def show
    @job = Job.find(params[:id])
    authorize @job
  end

  def update
    @job = Job.find(params[:id])
    if @job.update(job_params)
      render :show
    else
      render_error
    end
  end

  def job_params
    params.require(:job).permit(:name, :address)
  end

  def render_error
    render json: { errors: @job.errors.full_messages },
      status: :unprocessable_entity
  end
end