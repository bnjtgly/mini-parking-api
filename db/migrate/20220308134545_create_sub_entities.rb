class CreateSubEntities < ActiveRecord::Migration[7.0]
  def change
    create_table :sub_entities, id: :uuid do |t|
      t.references :entity, null: false, foreign_key: true, type: :uuid
      t.string :sort_order
      t.string :display
      t.string :value_str
      t.jsonb :metadata, null: false, default: '{}'
      t.string :status, default: 'Active'

      t.timestamps
    end
    add_index :sub_entities, %i[entity_id display value_str], unique: true
  end
end
