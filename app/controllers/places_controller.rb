class PlacesController < ApplicationController

    def index
        @places = Place.all
        respond_to do |format|
          format.html { render :index }
          format.json { render json: @places}
        end
      end
    
      def show
        @place = Place.find(params[:id])
        if current_user
          @comment = current_user.comments.build(place: @place)
        end
        respond_to do |format|
          format.html { render :show }
          format.json { render json:  @place }
        end
      end

      def new
        @place ||= Place.new
        @place.build_food
      end
    
      def create
        @place = current_user.places.new(place_params)
    
        if @place.save
          redirect_to place_path(@place)
        else
          redirect_to new_place_path, alert: "You must add a title, content and location in order to create a story."
        end
      end
    
      def edit
        @place = Place.find(params[:id])
      end
    
      def update
        @place = Place.find(params[:id])
        if !current_user
          redirect_to new_user_session_path, alert: "You must be the author in order to edit a story."
        elsif current_user != @place.user
          redirect_to :back, alert: "You must be the author in order to edit a story."
        else
          @place.update(place_params)
          redirect_to place_path(@place)
        end
      end
    
      def destroy
        @place = Place.find(params[:id])
        if !current_user
          redirect_to new_user_session_path, alert: "You must be the author in order to delete a story."
        elsif current_user != @place.user
          redirect_to :back, alert: "You must be the author in order to delete a story."
        else
          @place.destroy
          redirect_to places_path
        end
      end

      private

      def place_params
        params.require(:place).permit(:title)
      end
    
end
