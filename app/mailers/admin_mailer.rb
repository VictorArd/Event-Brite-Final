class AdminMailer < ApplicationMailer
  default from: 'no-reply@event-brite-clone.herokuapp.com'

  def join_event(event)
    @event = event

    @url  = 'https://event-brite-clone.herokuapp.com/login'

    mail(to: @event.admin.email, subject: 'Nouveau participant !')
  end
end
