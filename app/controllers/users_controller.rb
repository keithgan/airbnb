class UsersController < Clearance::UsersController

    def profile
      #do somethin
      @user = current_user
      # @listings = @user.listings

      # automatically renders a profile.html.erb
      
    end

    private

    def user_from_params
      email = user_params.delete(:email)
      password = user_params.delete(:password)
      first_name = user_params.delete(:first_name)
      last_name = user_params.delete(:last_name)

      Clearance.configuration.user_model.new(user_params).tap do |user|
        user.email = email
        user.password = password
        user.first_name = first_name
        user.last_name = last_name
      end
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password)
    end
end
