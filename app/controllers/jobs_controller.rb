class JobsController < ApplicationController
  before_action :set_job, only: [:waiting_for, :show]

  def index
    @jobs = policy_scope(Job).all
  end

  def show
    @waiting_for = waiting_for
  end

  private

  def set_job
    @job = policy_scope(Job).find(params[:id])
    authorize @job
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
    # (If so, display the call to action button)
    return current_user.user_type == waiting_for
  end
end
