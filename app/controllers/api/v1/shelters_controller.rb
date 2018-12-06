module Api
  module V1
    class SheltersController < ApplicationController
      before_action :authenticate_user
      before_action :authorize_as_client
      before_action :set_shelter, only: [:show, :destroy]

      def create
        shelter = Shelter.new(shelter_params)
        if shelter.save!
          render json: {msg: 'Shelter was created.', shelter_id: shelter.id},
                 status: :created
        end
      end

      def show
        return render json: @shelter
      end

      def destroy
        @shelter.destroy
        render json: {msg: 'record is destroyed'},
               status: :no_content
      end

      private

      def shelter_params
        params.require(:shelter).require(:name)
        params.require(:shelter).permit(:location, :name)
      end

      def set_shelter
        @shelter = Shelter.find(params[:id])
      end

    end
  end
end
