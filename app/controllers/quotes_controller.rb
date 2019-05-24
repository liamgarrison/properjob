class QuotesController < ApplicationController
  before_action :set_job, only: [:create]

  def index
    @quotes = Quote.all
    authorize @quote
  end

  def create
    @contractor_params = contractor_params
    contractor_ids = @contractor_params["contractors"].map(&:to_i)
    contractor_ids.each do |id|
      Quote.create(contractor_id: id, job_id: params[:job_id], submitted: false)
    end
    @job.increment!(:current_stage)
    redirect_to job_path(@job)
  end

  private

  def contractor_params
    params.permit(contractors: [])
  end

  def set_job
    @job = Job.find(params[:job_id])
  end
end
