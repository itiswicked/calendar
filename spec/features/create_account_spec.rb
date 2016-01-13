require 'rails_helper'

feature 'user creates account' do

# As a user
# I want to be able to create an Account
# so I can sign in to my account
#
# Acceptance Criteria
# [ ] At the root of the application, there should be a link for creating a new
#     account.
# [ ] This link leads to a form that user fill out to create an account.
# [ ] Fields included should be a first name, last name, email address,
#     username, password, and password confirmation.
# [ ] Upon successful submission, a user is sees to their own calendar.
# [ ] Upon unsuccessful submission, a user is directed the form again, with
#     appropriate errors displayed.
# [ ] Username must be unique.

  scenario 'successfully, granted access' do
    visit '/'
    save_and_open_page
    click_link 'Sign Up'

    fill_in 'First Name', with: 'Max'
    fill_in 'Last Name', with: 'Brener'
    fill_in 'Email', with: 'example@example.com'
    fill_in 'Password', with: 'password01'
    fill_in 'Password confirmation', with: 'password01'
    click_button 'Create Account'

    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end

  scenario 'and has mismatching passwords'

  scenario 'and leaves fields blank'
end
