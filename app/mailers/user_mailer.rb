class UserMailer < ActionMailer::Base
  default from:'veridiandynamicos.roomer@gmail.com'
  def confirmation_email(event)
    @event = event
    mail(to: event.contactEmail, subject: 'roomER has updated your event!')
  end
end
