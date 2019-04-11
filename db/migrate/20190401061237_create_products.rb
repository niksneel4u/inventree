class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :product_url
      t.references :marketplace, foreign_key: true
      t.references :company, foreign_key: true
      t.timestamps
    end
  end
end
