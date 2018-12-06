class AddNameToShelter < ActiveRecord::Migration[5.2]
  def change
    add_column :shelters, :name, :string, allow_nil: false
  end
end
