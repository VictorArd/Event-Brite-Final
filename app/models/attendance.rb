class Attendance < ApplicationRecord
  after_create :join_send
  #
  belongs_to :user
  belongs_to :event

  #Validations


  #
  def join_send
    AdminMailer.join_event(Event.find(event_id)).deliver_now
  end
end
