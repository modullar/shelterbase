class AnimalSerializer
  include FastJsonapi::ObjectSerializer
  attributes :temp_name, :medical_condition, :race, :pending_adoption, :shelter_name

end
