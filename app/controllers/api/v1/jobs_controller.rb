class Api::V1::JobsController < Api::V1::BaseController
  skip_after_action :verify_authorized

  def index
    @jobs = Job.all
  end

  def show
    @jobs = Job.find(params[:id])
  end
end