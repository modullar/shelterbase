class User < ApplicationRecord
  self.inheritance_column = 'role'


  # Necessary to authenticate.
  has_secure_password

  # Basic password validation, configure to your liking.
  validates_length_of       :password, maximum: 72, minimum: 3, allow_nil: false, allow_blank: false
  validates_confirmation_of :password, allow_nil: true, allow_blank: false

  before_validation {
    (self.email = self.email.to_s.downcase) && (self.username = self.username.to_s.downcase)
  }

  # Make sure email and username are present and unique.
  validates_presence_of     :email
  validates_presence_of     :username
  validates_uniqueness_of   :email
  validates_uniqueness_of   :username
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP } 


  %w( admin client worker).each do |role_name|
    define_method ("is_#{role_name}?") do
      role&.downcase == role_name&.downcase
    end
  end


end
