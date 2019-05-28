class PaymentsController < ApplicationController
  before_action :set_job, only: [:create]

  def create
    customer = Stripe::Customer.create(
       source: params[:stripeToken],
       email:  params[:stripeEmail]
     )

    charge = Stripe::Charge.create(
      customer:     customer.id, # You should store this customer id and re-use it.
      amount:       @job.final_price * 100, # Need to use monetize gem for this
      description:  "Payment for job ##{@job.id}",
      currency:     "GBP"
    )

    @job.update(current_stage: 9)
    redirect_to job_path(@job)

    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to job_path(@job)
  end

  private

  def set_job
    @job = Job.find(params[:job_id])
  end
end
