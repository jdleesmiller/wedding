# frozen_string_literal: true

require 'test_helper'

class GuestsControllerTest < ActionDispatch::IntegrationTest
  test 'checks for duplicates on email update' do
    guest_one = guests(:one)
    guest_two = guests(:two)

    patch guest_path(guest_one), params: {
      guest: { email: guest_two.email }
    }

    assert_select 'li', 'Email has already been taken'
  end

  test 'records confirmed_at time' do
    guest_one = guests(:one)

    patch complete_guest_path(guest_one), params: { guest: { notes: '' } }

    guest_one.reload
    assert guest_one.confirmed_at
  end
end
