class CreateCustomerParkings < ActiveRecord::Migration[7.0]
  def change
    create_table :customer_parkings, id: :uuid do |t|
      t.references :customer, null: false, foreign_key: true, type: :uuid
      t.references :parking_slot, null: false, foreign_key: true, type: :uuid
      t.references :parking_status, references: :sub_entities, foreign_key: { to_table: :sub_entities }, type: :uuid
      t.boolean :is_returnee, null: false, default: false
      t.integer :current_flat_rate, null: false, default: 3
      t.integer :accumulated_hours, null: false, default: 0
      t.datetime :valid_from, null: false, default: -> { 'NOW()' }
      t.datetime :valid_thru

      t.timestamps
    end
  end
end
