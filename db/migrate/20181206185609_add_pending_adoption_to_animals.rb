class AddPendingAdoptionToAnimals < ActiveRecord::Migration[5.2]
  def change
    add_column :animals, :pending_adoption, :boolean, allow_nil: false, default: false
  end
end
