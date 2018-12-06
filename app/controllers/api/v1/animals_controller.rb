module Api
  module V1

    class AnimalsController < ApplicationController
      before_action :set_animal, only: :show

      def index
        @animals = Animal.where(search_params)
        render json: {animals: @animals}
      end

      def show
        render json: @animal
      end

      private

      def set_animal
        @animal = Animal.find(params[:id])
      end

      def search_params
        hash = {}
        return hash unless params['animal']
        if !params['animal']['shelter_name'].nil?
          hash = hash.merge({shelter_name: params['animal']['shelter_name']})
        end
        if !params['animal']['pending_adoption'].nil?
          hash= hash.merge({pending_adoption: params['animal']['pending_adoption']})
        end
        hash
      end

    end

  end
end
