class ReservationsController < ApplicationController
    def index
        @reservations = Reservation.all
    end

    def show
        @reservation = Reservation.find_by(params[:id])
    end

    def new
        @reservation = Reservation.new
    end

    def create
        @reservation = Reservation.new(reservation_params)
        @listing = Listing.find(params[:listing_id])
        @reservation.listing_id = @listing.id
        @reservation.user_id = current_user.id
        
        if @reservation.save
            redirect_to braintree_new_path(@reservation)
        else
            render 'listings/show'
        end
    end

    def destroy    
        @reservation = Reservation.find_by(params[:reservation_id])
        @reservation.destroy
        redirect_to user_path
    end

    private
    def reservation_params
        params.require(:reservation).permit(
            :check_in,
            :check_out,
            :no_of_guests,
            :total_price
        )
    end
end
