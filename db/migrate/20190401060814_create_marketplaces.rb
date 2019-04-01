class CreateMarketplaces < ActiveRecord::Migration[6.0]
  def change
    create_table :marketplaces do |t|
      t.string :name
      t.string :website_url

      t.timestamps
    end
  end
end
