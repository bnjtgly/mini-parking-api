class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers, id: :uuid do |t|
      t.references :vehicle_type, references: :sub_entities, foreign_key: { to_table: :sub_entities}, type: :uuid
      t.string :complete_name
      t.string :plate_number

      t.timestamps
    end
  end
end
