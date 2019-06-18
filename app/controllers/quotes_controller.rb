class QuotesController < ApplicationController
  before_action :set_job, only: [:create, :update]

  def index
    @quotes = policy_scope(Quote)
  end

  def create
    contractor_ids = params[:contractor_selected].split(",").reject(&:blank?)
    contractor_ids.each do |id|
      @quote = Quote.create(contractor_id: id, job_id: params[:job_id], submitted: false)
      authorize @quote
    end
    @job.update(current_stage: 2)
    redirect_to job_path(@job)
  end

  def update
    @quote = Quote.find(params[:id])
    authorize @quote
    @quote.update(quote_params)
    @quote.update(submitted: true)
    if @job.quotes.all?{ |quote| quote.submitted }
      @job.update(current_stage: 3)
    end
    redirect_to job_path(@job)
  end

  private

  def quote_params
    params.require(:quote).permit(:price, :quote)
  end

  def set_job
    @job = Job.find(params[:job_id])
  end
end
