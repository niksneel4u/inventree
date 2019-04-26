class CreateMarketplaces < ActiveRecord::Migration[6.0]
  def change
    create_table :marketplaces do |t|
      t.string :name
      t.string :website_url
      t.string :image_xpath

      t.timestamps
    end
    add_index :marketplaces, :website_url, unique: true
  end
end
