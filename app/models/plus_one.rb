# frozen_string_literal: true

#
# An extra guest.
#
class PlusOne < ApplicationRecord
  belongs_to :guest

  auto_strip_attributes :first_name, :last_name, :diet

  validates :first_name, presence: true
  validates :first_name, length: { maximum: 1024 }
  validates :last_name, presence: true
  validates :last_name, length: { maximum: 1024 }

  def name
    "#{first_name} #{last_name}"
  end

  validates :diet, length: { maximum: 8192 }
end
