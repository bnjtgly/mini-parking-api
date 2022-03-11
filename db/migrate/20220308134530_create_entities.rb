class CreateEntities < ActiveRecord::Migration[7.0]
  def change
    create_table :entities, id: :uuid do |t|
      t.integer :entity_number
      t.string :entity_name
      t.string :entity_def

      t.timestamps
    end
    add_index :entities, :entity_number, unique: true
  end
end
