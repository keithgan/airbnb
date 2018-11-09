class BraintreeController < ApplicationController
  def new
    @client_token = Braintree::ClientToken.generate
    @reservation = Reservation.find(params[:reservation_id])
  end

  def checkout
    @reservation = Reservation.find(params[:id])
    nonce_from_the_client = params[:checkout_form][:payment_method_nonce]
  
    result = Braintree::Transaction.sale(
     :amount => @reservation.total_price,
     :payment_method_nonce => nonce_from_the_client,
     :options => {
        :submit_for_settlement => true
      }
     )
  
    if result.success?
      ReservationJob.perform_now(current_user, @reservation.listing.user)
      # ReservationMailer.confirmation_email(current_user, @reservation.listing.user).deliver_now
      redirect_to user_path(current_user), :flash => { :success => "Transaction successful!" }
    else
      redirect_to user_path(current_user), :flash => { :error => "Transaction failed. Please try again." }
    end
  end
end


