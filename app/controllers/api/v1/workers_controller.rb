module Api
  module V1
    class WorkersController < ApplicationController

      before_action :authenticate_user
      before_action :authorize_as_client
      before_action :set_worker, only: [:show, :destroy]
      before_action :set_shelter, only: :create

      def create
        worker = Worker.new(worker_params)
        if worker.save!
          render json: {msg: 'Worker was created.', worker_id: worker.id},
                 status: :created
        end
      end

      def show
        return render json: @worker
      end

      def destroy
        @worker.destroy
        render json: {msg: 'record is destroyed'},
               status: :no_content
      end

      private

      def worker_params
        params.require(:worker).require(:email)
        params.require(:worker).require(:username)
        params.require(:worker).require(:password)
        params.require(:worker).require(:shelter_id)
        params.require(:worker).permit(:email, :username, :password, :shelter_id)
      end

      def set_worker
        @worker = Worker.find(params[:id])
      end

      # Need cleaning
      def set_shelter
        @shelter = Shelter.find(params[:worker][:shelter_id])
      end

    end
  end
end
