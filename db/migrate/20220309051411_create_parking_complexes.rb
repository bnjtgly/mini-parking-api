class CreateParkingComplexes < ActiveRecord::Migration[7.0]
  def change
    create_table :parking_complexes, id: :uuid do |t|
      t.string :name

      t.timestamps
    end
    add_index :parking_complexes, :name, unique: true
  end
end
