# frozen_string_literal: true

#
# A primary guest.
#
class Guest < ApplicationRecord
  include FindableWithToken

  auto_strip_attributes :email, :first_name, :last_name, :diet, :songs, :notes

  validates :email, presence: true, uniqueness: true
  validates :email, format: Devise.email_regexp, allow_blank: true

  validates :first_name, presence: true, if: :persisted?
  validates :first_name, length: { maximum: 1024 }
  validates :last_name, presence: true, if: :persisted?
  validates :last_name, length: { maximum: 1024 }

  def name
    "#{first_name} #{last_name}"
  end

  def name_with_email
    "#{name} <#{email}>"
  end

  # Don't allow long or odd names in emails; may be spam.
  def email_safe_salutation
    return 'Hello,' if
      first_name.blank? || first_name !~ /\A[\p{Word}\s'-]{1,30}\z/i

    "Dear #{first_name},"
  end

  validates :diet, length: { maximum: 8192 }
  validates :songs, length: { maximum: 8192 }
  validates :notes, length: { maximum: 8192 }

  has_many :plus_ones, dependent: :destroy

  scope :confirmed, -> { where.not(confirmed_at: nil) }
  scope :attending, -> { confirmed.where(attending: true) }
  scope :not_attending, -> { confirmed.where(attending: false) }
end
