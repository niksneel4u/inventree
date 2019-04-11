class CreateProductEntities < ActiveRecord::Migration[6.0]
  def change
    create_table :product_entities do |t|
      t.references :product, foreign_key: true
      t.references :entity, foreign_key: true
      t.string :value

      t.timestamps
    end
  end
end
