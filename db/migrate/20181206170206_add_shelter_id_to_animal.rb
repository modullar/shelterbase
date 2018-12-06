class AddShelterIdToAnimal < ActiveRecord::Migration[5.2]
  def change
    add_reference :animals, :shelter, index: true
  end
end
