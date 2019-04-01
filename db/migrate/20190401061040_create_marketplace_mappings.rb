class CreateMarketplaceMappings < ActiveRecord::Migration[6.0]
  def change
    create_table :marketplace_mappings do |t|
      t.references :marketplace, foreign_key: true
      t.references :entity, foreign_key: true
      t.string :entity_identifier
      t.string :entity_identifier_value

      t.timestamps
    end
    add_index :marketplace_mappings, [:marketplace_id, :entity_id], unique: true
  end
end
