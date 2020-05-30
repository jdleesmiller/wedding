# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/guest_mailer
class GuestMailerPreview < ActionMailer::Preview
  def confirmation_email_attending
    GuestMailer.confirmation_email(
      Guest.new(
        id: 123,
        first_name: 'John',
        last_name: 'Doe',
        email: 'john.doe@example.com',
        token: 'abcdefghiklmnop',
        attending: true
      )
    )
  end

  def confirmation_email_attending_not_attending
    GuestMailer.confirmation_email(
      Guest.new(
        id: 123,
        first_name: 'John',
        last_name: 'Doe',
        email: 'john.doe@example.com',
        token: 'abcdefghiklmnop',
        attending: false
      )
    )
  end
end
