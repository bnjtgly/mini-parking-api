class CreateSlotEntrypoints < ActiveRecord::Migration[7.0]
  def change
    create_table :slot_entrypoints, id: :uuid do |t|
      t.references :parking_slot, null: false, foreign_key: true, type: :uuid
      t.references :entry_point, null: false, foreign_key: true, type: :uuid
      t.float :distance

      t.timestamps
    end
  end
end
