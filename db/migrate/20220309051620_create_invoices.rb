class CreateInvoices < ActiveRecord::Migration[7.0]
  def change
    create_table :invoices, id: :uuid do |t|
      t.references :customer_parking, null: false, foreign_key: true, type: :uuid
      t.references :transaction_status, references: :sub_entities, foreign_key: { to_table: :sub_entities }, type: :uuid
      t.integer :parked_hours
      t.float :parking_fee

      t.timestamps
    end
  end
end
