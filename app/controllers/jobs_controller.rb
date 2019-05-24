class JobsController < ApplicationController
  before_action :set_job, only: [:show]

  def index
    @jobs = policy_scope(Job).all
  end

  def show
  end

  private

  def set_job
    @job = policy_scope(Job).find(params[:id])
    authorize @job
  end
end
