class Invoice < ApplicationRecord
  belongs_to :customer_parking
  belongs_to :customer

  # Sub Entities Association
  # List all sub_entities columns in users table.
  belongs_to :transaction_status_ref, class_name: 'SubEntity', foreign_key: 'transaction_status_id', optional: true

end
