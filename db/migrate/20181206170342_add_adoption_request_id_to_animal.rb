class AddAdoptionRequestIdToAnimal < ActiveRecord::Migration[5.2]
  def change
    add_reference :animals, :adoption_request, index: true
  end
end
