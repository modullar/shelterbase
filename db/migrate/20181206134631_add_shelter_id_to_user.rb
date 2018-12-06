class AddShelterIdToUser < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :shelter, index: true
  end
end
