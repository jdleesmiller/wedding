# frozen_string_literal: true

class AddGuestInfo < ActiveRecord::Migration[5.1]
  def change
    enable_extension('citext')

    change_table :guests do |t|
      t.change :email, :citext, null: false
      t.index :email, unique: true

      t.string :token, null: false
      t.boolean :attending
      t.integer :diet
      t.string :other_diet
    end
  end
end
