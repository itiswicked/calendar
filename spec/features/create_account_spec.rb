require 'rails_helper'

feature 'user creates account' do

# As a user
# I want to be able to create an Account
# so I can sign in to my account
#
# Acceptance Criteria
# [x] At the root of the application, there should be a link for creating a new
#     account.
# [x] This link leads to a form that user fill out to create an account.
# [x] Fields included should be a first name, last name, email address,
#     password, and password confirmation.
# [ ] Upon successful submission, a user is sees to their own calendar.
# [ ] Upon unsuccessful submission, a user is directed the form again, with
#     appropriate errors displayed.
# [ ] Username must be unique.

  before(:each) { visit new_user_registration_path }

  scenario 'successfully, granted access' do
    fill_in 'First Name', with: 'Max'
    fill_in 'Last Name', with: 'Payne'
    fill_in 'Email', with: 'example@example.com'
    fill_in 'Password', with: 'password01'
    fill_in 'Password confirmation', with: 'password01'
    click_button 'Create Account'


    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end

  scenario 'and has mismatching passwords' do
    fill_in 'First Name', with: 'Max'
    fill_in 'Last Name', with: 'Payne'
    fill_in 'Email', with: 'example@example.com'
    fill_in 'Password', with: 'password01'
    fill_in 'Password', with: 'not_the_same'
    click_button 'Create Account'

    expect(page).to have_content "Password confirmation doesn't match Password"
  end


  scenario 'and leaves fields blank' do
    click_button 'Create Account'

    expect(page).to have_content "Email can't be blank"
    expect(page).to have_content "Password can't be blank"
  end
end
