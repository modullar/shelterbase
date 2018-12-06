class Shelter < ApplicationRecord
  has_many :workers
  has_many :animals

  validates_presence_of   :name
  validates_uniqueness_of :name
end
