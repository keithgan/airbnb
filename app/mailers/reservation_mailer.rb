class ReservationMailer < ApplicationMailer
    default from: 'testbnb123@gmail.com'
 
  def confirmation_email(user, host)
    @user = user
    @host = host
    mail(to: @host.email, subject: 'Booking confirmation.')
  end
end
