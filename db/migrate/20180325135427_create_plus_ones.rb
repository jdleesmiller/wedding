# frozen_string_literal: true

class CreatePlusOnes < ActiveRecord::Migration[5.1]
  def change
    create_table :plus_ones do |t|
      t.references :guest, foreign_key: true
      t.string :name
      t.integer :diet
      t.string :other_diet
      t.boolean :child

      t.timestamps
    end
  end
end
