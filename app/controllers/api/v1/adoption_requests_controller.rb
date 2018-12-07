module Api
  module V1

    class AdoptionRequestsController < ApplicationController

      before_action :set_animal, only: :create
      before_action :authorize_create, only: :create

      def create
        adoption_request = AdoptionRequest.new(adoption_request_params)
        adoption_request.animal = @animal
        if adoption_request.save!
          render_payload("Adoption #{adoption_request.id} Request was created",
                         :created)
        else
          render_payload("Adoption Request could not be saved", :bad_request)
        end
      end

      private

      def adoption_request_params
        params.require(:adoption_request).require(:name)
        params.require(:adoption_request).require(:email)
        params.require(:adoption_request).require(:telephone_number)
        params.require(:adoption_request).require(:animal_id)
        params.require(:adoption_request).permit(:name,
                                                 :email,
                                                 :telephone_number,
                                                 :animal_id)
      end

      def set_animal
        @animal = Animal.find(params[:adoption_request][:animal_id])
      end

      def authorize_create
        return unless @animal.pending_adoption # animal does not have pending adoption
        render_payload("Animal #{@animal.id} has alrady a pending request",
                       :forbidden)
      end

    end
  end
end
