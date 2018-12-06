class Animal < ApplicationRecord

  has_one :adoption_request
  belongs_to :shelter, required: true

  validates_presence_of     :race
  validates_presence_of     :medical_condition
  validates_presence_of     :temp_name

  before_save :update_pending_adoption
  before_save :update_shelter_name

  private

  def update_pending_adoption
    self.pending_adoption =  adoption_request.nil? ? false : true
  end

  def update_shelter_name
    self.shelter_name = shelter.name
  end

end
