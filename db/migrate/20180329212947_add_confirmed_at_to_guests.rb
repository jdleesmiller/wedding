# frozen_string_literal: true

class AddConfirmedAtToGuests < ActiveRecord::Migration[5.1]
  def change
    change_table :guests do |t|
      t.datetime :confirmed_at
    end
  end
end
