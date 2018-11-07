class Reservation < ApplicationRecord
    belongs_to :user
    belongs_to :listing
    validate :reservation_is_available
    validate :dates_in_the_past
    validate :check_in_before_check_out
    before_save :total_price

    def reservation_is_available
        self.listing.reservations.each do |reservation|
            if (self.check_in..self.check_out).overlaps?(reservation.check_in..reservation.check_out)
                errors.add(:dates_booked, "These dates are not available. Please choose other dates.")
            end
        end
    end

    def dates_in_the_past
        if self.check_in < Date.today
            errors.add(:past_dates, "Cannot select these dates. Please try again.")
        end
    end

    def check_in_before_check_out
        if self.check_out < self.check_in
            errors.add(:incorrect_dates, "Check in has to be before check out")
        end
    end

    def total_price
        self.total_price = (check_out - check_in).to_i * self.listing.price_per_night
    end
end