# frozen_string_literal: true

class SimplifyDiet < ActiveRecord::Migration[5.1]
  def change
    change_table :guests do |t|
      t.remove :other_diet
      t.change :diet, :string
      t.string :songs
    end

    change_table :plus_ones do |t|
      t.remove :other_diet
      t.change :diet, :string
    end
  end
end
