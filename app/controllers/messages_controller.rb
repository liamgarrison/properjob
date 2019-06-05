class MessagesController < ApplicationController
  def index
    @job = Job.find(params[:job_id])
  end

  def create
    raise
  end
end
