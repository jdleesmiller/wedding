# frozen_string_literal: true

require 'application_system_test_case'

class RsvpHappyPathTest < ApplicationSystemTestCase
  test 'RSVP attending' do
    visit root_url
    click_link 'RSVP TODAY!', match: :first

    fill_in 'Email', with: 'test@example.com'
    click_on 'Continue'

    #
    # About You
    #
    fill_in 'First Name', with: 'Test'
    fill_in 'Last Name', with: 'User'
    choose 'Yes'
    fill_in 'Dietary Preferences', with: 'Level 5 Vegan'
    fill_in 'Song Suggestions', with: 'Mozart'
    click_on 'Continue'

    #
    # Plus Ones
    #
    click_on 'Add Plus One'

    fill_in 'First Name', with: 'Test Plus'
    fill_in 'Last Name', with: 'One Name'
    fill_in 'Dietary Preferences', with: 'Vegetarian'
    check 'Child'
    click_on 'Add Plus One'

    assert page.has_content? 'Test Plus One Name'

    click_on 'Add Plus One'

    fill_in 'First Name', with: 'Test Plus'
    fill_in 'Last Name', with: 'Two Name'
    fill_in 'Dietary Preferences', with: 'Pescatarian'
    check 'Child'
    click_on 'Add Plus One'

    assert page.has_content? 'Test Plus One Name'
    assert page.has_content? 'Test Plus Two Name'

    click_on 'Continue'

    #
    # Confirm
    #

    assert page.has_content? 'Test User'
    assert page.has_content? 'Level 5 Vegan'
    assert page.has_content? 'Mozart'
    assert page.has_content? 'Test Plus One Name'
    assert page.has_content? 'Vegetarian'
    assert page.has_content? 'Test Plus Two Name'
    assert page.has_content? 'Pescatarian'

    fill_in 'guest[notes]', with: 'I hope there is cake!'

    click_on 'Complete RSVP'

    assert_equal 1, ActionMailer::Base.deliveries.size
    email = ActionMailer::Base.deliveries.last
    assert_equal 'test@example.com', email.to[0]
  end

  test 'RSVP not attending' do
    visit root_url
    click_link 'RSVP TODAY!', match: :first

    fill_in 'Email', with: 'test@example.com'
    click_on 'Continue'

    #
    # About You
    #
    fill_in 'First Name', with: 'Test'
    fill_in 'Last Name', with: 'User'
    choose 'No'

    click_on 'Continue'

    #
    # Skip to Confirm
    #
    assert page.has_content? 'Test User'
    assert page.has_content? 'Sorry to hear'

    click_on 'Complete RSVP'

    assert_equal 1, ActionMailer::Base.deliveries.size
    email = ActionMailer::Base.deliveries.last
    assert_equal 'test@example.com', email.to[0]
  end

  test 'Sends RSVP update email' do
    visit root_url
    click_link 'RSVP TODAY!', match: :first

    fill_in 'Email', with: 'test@example.com'
    click_on 'Continue'

    fill_in 'First Name', with: 'Test'
    fill_in 'Last Name', with: 'User'

    click_on 'Continue'
    click_on 'Continue' # No plus ones
    click_on 'Complete RSVP'

    assert_equal 1, ActionMailer::Base.deliveries.size

    visit root_url
    click_link 'RSVP TODAY!', match: :first

    fill_in 'Email', with: 'test@example.com'
    click_on 'Continue'

    assert page.has_content? 'Welcome Back'

    assert_equal 2, ActionMailer::Base.deliveries.size
    email = ActionMailer::Base.deliveries.last
    assert_equal 'test@example.com', email.to[0]
  end
end
