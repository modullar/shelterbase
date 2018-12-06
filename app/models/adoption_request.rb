class AdoptionRequest < ApplicationRecord

  has_one :animal, required: true

  validates_presence_of     :email
  validates_presence_of     :name
  validates_presence_of     :telephone_number

end
