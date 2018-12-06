# Error module to Handle errors globally
# include Error::ErrorHandler in application_controller.rb
module Error
  module ErrorHandler
    def self.included(clazz)
      clazz.class_eval do
        rescue_from Exception, with: :error_occured
        rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
      end
    end

    private

    def record_not_found(_e)
      render json: {
        error: _e.to_s
      }, status: :not_found
    end

    def error_occured(_e)
      logger.error "Exception occured #{_e}"
      render json: {
        error: "Error occured please contact the provider"
      }, status: 500
    end

  end
end
