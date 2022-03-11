class CreateParkingSlots < ActiveRecord::Migration[7.0]
  def change
    create_table :parking_slots, id: :uuid do |t|
      t.references :parking_complex, null: false, foreign_key: true, type: :uuid
      t.references :parking_slot_type, references: :sub_entities, foreign_key: { to_table: :sub_entities}, type: :uuid
      t.references :parking_slot_status, references: :sub_entities, foreign_key: { to_table: :sub_entities}, type: :uuid
      t.string :name
      t.jsonb :entry_point_distance
      t.float :price

      t.timestamps
    end
  end
end
