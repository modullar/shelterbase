include ActionController::HttpAuthentication::Basic::ControllerMethods
include ActionController::HttpAuthentication::Token::ControllerMethods

class ApplicationController < ActionController::API

  include Knock::Authenticable
  include Error::ErrorHandler


  protected



  def render_payload(msg, status)
    render json: {msg: msg}, status: status
  end



  %w(admin worker client).each do |role_name|
    define_method "authorize_as_#{role_name}" do
      return head(:unauthorized) unless !current_user.nil? && current_user.send("is_#{role_name}?")
    end
  end

end
