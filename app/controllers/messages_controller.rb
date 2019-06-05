class MessagesController < ApplicationController
  def index
    @job = Job.find(params[:job_id])
    @messages = Message.where(job: @job)
  end

  def create
    job = Job.find(params[:job_id])
    @message = Message.new(message_params)
    @message.user = current_user
    @message.job = job
    @message.save
    respond_to do |format|
      format.html { redirect_to job_messages_path(job) }
      format.js
    end
  end

  def message_params
    params.require(:message).permit(:content, :job)
  end
end
