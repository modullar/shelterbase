module Api
  module V1
    class WorkersController < ApplicationController

      before_action :authenticate_user
      before_action :authorize_as_client
      before_action :set_worker, only: [:show, :destroy]

      def create
        worker = Worker.new(worker_params)
        if worker.save!
          render_payload("Worker #{worker.id} Request was created",
                         :created)
        end
      end

      def show
        return render json: Api::V1::WorkerSerializer.new(@worker).serialized_json        
      end

      def destroy
        @worker.destroy
        render_payload("record is destroyed", :accepted)
      end

      private

      def worker_params
        params.require(:worker).require(:email)
        params.require(:worker).require(:username)
        params.require(:worker).require(:shelter_id)
        params.require(:worker).require(:password)
        params.require(:worker).permit(:email, :username, :password, :shelter_id)
      end

      def set_worker
        @worker = Worker.find(params[:id])
      end

    end
  end
end
