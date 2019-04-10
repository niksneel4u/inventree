class CreateReceiverEmails < ActiveRecord::Migration[6.0]
  def change
    create_table :receiver_emails do |t|
      t.string :name
      t.string :email
      t.references :company, foreign_key: true
      t.timestamps
    end
  end
end
