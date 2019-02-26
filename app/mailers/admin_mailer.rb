class AdminMailer < ApplicationMailer
  default from: 'no-reply@eventbriteclone.fr'

  def join_event(event)
    @event = event

    @url  = 'http://eventbriteclone/login'

    mail(to: @event.admin.email, subject: 'Nouveau participant !')
  end
end
