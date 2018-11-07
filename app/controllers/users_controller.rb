class UsersController < Clearance::UsersController

    def show
      @user = current_user
      @reservations = Reservation.all
    end

    def edit
      @listing = Listing.find(params[:id])
    end

    def update
      @user = User.find(params[:id])
      @user.update(user_params)
      redirect_to @user 
    end

    def user_from_params
      email = user_params.delete(:email)
      password = user_params.delete(:password)
      first_name = user_params.delete(:first_name)
      last_name = user_params.delete(:last_name)
      gender = user_params.delete(:gender)
      
      Clearance.configuration.user_model.new(user_params).tap do |user|
        user.email = email
        user.password = password
        user.first_name = first_name
        user.last_name = last_name
        user.gender = gender
      end
    end

    def user_params
      params.require(:user).permit(
        :first_name, 
        :last_name, 
        :email, 
        :password,
        :gender,
        :birthday,
        :phone_number,
        :description, 
        :avatar
        )
    end
end
