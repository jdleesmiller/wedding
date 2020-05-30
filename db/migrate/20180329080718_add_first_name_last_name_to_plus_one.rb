# frozen_string_literal: true

class AddFirstNameLastNameToPlusOne < ActiveRecord::Migration[5.1]
  def change
    change_table :plus_ones do |t|
      t.remove :name
      t.string :first_name
      t.string :last_name
    end
  end
end
