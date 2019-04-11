# frozen_string_literal: true

class CreateMailLists < ActiveRecord::Migration[6.0]
  def change
    create_table :mail_lists do |t|
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end
