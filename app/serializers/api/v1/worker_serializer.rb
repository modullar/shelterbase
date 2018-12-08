class Api::V1::WorkerSerializer
  include FastJsonapi::ObjectSerializer
  attributes :username, :email, :shelter_id
end
