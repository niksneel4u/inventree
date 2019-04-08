# frozen_string_literal: true

class CreateCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :contact_person_name
      t.string :contact_person_number, null: false, default: ''
      t.string :email
      t.boolean :terms_and_conditions
      t.text :address

      t.timestamps
    end
    add_index :companies, :contact_person_number, unique: true
  end
end
