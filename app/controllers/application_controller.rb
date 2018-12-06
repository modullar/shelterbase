class ApplicationController < ActionController::API

  include Knock::Authenticable
  include Error::ErrorHandler


  protected

  %w(admin worker client).each do |role_name|
    define_method "authorize_as_#{role_name}" do
      return head(:unauthorized) unless !current_user.nil? && current_user.send("is_#{role_name}?")
    end
  end

end
