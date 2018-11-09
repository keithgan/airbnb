class ReservationJob < ApplicationJob
  queue_as :default

  def perform(user, host)
    ReservationMailer.confirmation_email(user, host).deliver_now
  end
end
