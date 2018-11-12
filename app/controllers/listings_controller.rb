class ListingsController < ApplicationController
    before_action :verify_action, only: [:verify_listing]
    
    def index
        @listings = Listing.all.order("property_name").page params[:page]
        
        
        @listings = Listing.where(nil)
        filtering_params(params).each do |key, value|
            @listings = @listings.public_send(key, value) if value.present?                       
            #  this is what the above line does
            #   @listings.key(value)
            #   eg. @listing.search(malaysia)
        end
    end
    
    def show
        @listing = Listing.find(params[:id])
        @reservation = Reservation.new
    end

    def new
        @listing = Listing.new
    end

    def edit
        @listing = Listing.find(params[:id])
    end

    def create
        @listing = Listing.new(listing_params)
        @listing.user_id = current_user.id

        if @listing.save
            redirect_to @listing
        else
            render 'new'
        end
    end

    def update
        @listing = Listing.find(params[:id])

        if @listing.update(listing_params)
            redirect_to @listing
        else
            render 'edit'
        end
    end

    def destroy
        @listing = Listing.find(params[:id])
        @listing.destroy
        redirect_to listings_path
    end

    def verify_listing
        @listing = Listing.find(params[:id])
        @listing.update(verification: true)
        flash[:notice] = "Property successfully verified."
        return redirect_to listings_path      
    end

    def my_listings
        @my_listings = current_user.listings
    end
    
    private
    def listing_params
        params.require(:listing).permit(
            :property_type, 
            :property_name, 
            :no_of_guests, 
            :no_of_bedrooms, 
            :no_of_beds, 
            :no_of_bathrooms, 
            :amenities, 
            :price_per_night, 
            :country, 
            :state, 
            :city, 
            :zipcode, 
            :address, 
            {images: []}
        )
    end

    # If the user is a customer and the listing does not belong to them:
    def verify_action
        if current_user.customer?
            redirect_to root_url
        end
    end

    # A list of the param names that can be used for filtering the Product list
    def filtering_params(params)
        params.slice(:omnisearch)
    end
end