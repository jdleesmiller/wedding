# frozen_string_literal: true

class AddFirstNameLastNameToGuest < ActiveRecord::Migration[5.1]
  def change
    change_table :guests do |t|
      t.remove :name
      t.string :first_name
      t.string :last_name
    end
  end
end
