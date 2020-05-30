# frozen_string_literal: true

class CreateAttendees < ActiveRecord::Migration[5.1]
  def change
    create_view :attendees
  end
end
