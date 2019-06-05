class Message < ApplicationRecord
  belongs_to :user
  belongs_to :job
  after_create :broadcast_message

  def broadcast_message
    ActionCable.server.broadcast("messages_#{job.id}", {
      message_partial: ApplicationController.renderer.render(partial: "messages/message", locals: { message: self, belongs_to: 'theirs' }),
      message_owner_id: user.id
    })
  end
end
