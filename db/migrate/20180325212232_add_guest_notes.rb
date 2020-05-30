# frozen_string_literal: true

class AddGuestNotes < ActiveRecord::Migration[5.1]
  def change
    change_table :guests do |t|
      t.string :notes
    end
  end
end
