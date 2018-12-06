class CreateAdoptionRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :adoption_requests do |t|

      t.string :name, allow_nil: false
      t.string :email, allow_nil: false
      t.string :telephone_number, allow_nil: false

      t.timestamps
    end

    add_reference :adoption_requests, :animal, index: true
  end
end
