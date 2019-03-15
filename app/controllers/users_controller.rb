class UsersController < ApplicationController

    def show
        @user = User.find(params[:id])
      end
    
      def places
        if current_user
          @places = current_user.places
        end
      end
end
