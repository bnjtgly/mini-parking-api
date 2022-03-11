class CreateEntryPoints < ActiveRecord::Migration[7.0]
  def change
    create_table :entry_points, id: :uuid do |t|
      t.references :parking_complex, null: false, foreign_key: true, type: :uuid
      t.string :name

      t.timestamps
    end
  end
end
