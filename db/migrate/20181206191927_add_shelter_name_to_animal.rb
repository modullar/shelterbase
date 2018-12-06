class AddShelterNameToAnimal < ActiveRecord::Migration[5.2]
  def change
    add_column :animals, :shelter_name, :string, allow_nil: false
  end
end
