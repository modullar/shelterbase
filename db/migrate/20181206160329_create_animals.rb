class CreateAnimals < ActiveRecord::Migration[5.2]
  def change
    create_table :animals do |t|
      t.string :medical_condition
      t.string :temp_name
      t.string :race

      t.timestamps

    end
  end
end
