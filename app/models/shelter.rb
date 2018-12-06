class Shelter < ApplicationRecord
  has_many :workers
  has_many :animals
end
